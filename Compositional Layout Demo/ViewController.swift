//
//  ViewController.swift
//  Compositional Layout Demo
//
//  Created by MacMini1 on 20/08/21.
//  Copyright © 2021 bacancy. All rights reserved.
//

import UIKit

class Header : UICollectionReusableView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Categories"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class ViewController: UIViewController {
    
    static let categoryheader = "Categories"
    static let headerId = "headerId"
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createlayout()
        
        //registering cells
        collectionView.register(UINib(nibName: "FirstCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FirstCollectionViewCell")
        collectionView.register(UINib(nibName: "SecondCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SecondCollectionViewCell")
        collectionView.register(UINib(nibName: "ThirdCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ThirdCollectionViewCell")
        collectionView.register(UINib(nibName: "FourthCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FourthCollectionViewCell")
        collectionView.register(Header.self, forSupplementaryViewOfKind: ViewController.categoryheader, withReuseIdentifier: ViewController.headerId)
    }
    
    private func createlayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 5
                item.contentInsets.bottom = 20
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
            }
            else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(170)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
              
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50)), elementKind: ViewController.categoryheader, alignment: .topLeading)]
                
                return section
            } else if sectionNumber == 2 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1)))
                    item.contentInsets.trailing = 16
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(150))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                    let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 10
                section.orthogonalScrollingBehavior = .continuous
                    return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(300)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
               
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 30, leading: 16, bottom: 0, trailing: 0)
                
                return section
            }
           
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        else if section == 1 {
            return 6
        }
        else if section == 2 {
            return 3
        }
        else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if indexPath.section == 0 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
           return cell
       }
       else if indexPath.section == 1 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
           return cell
       }
       else if indexPath.section == 2 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as! ThirdCollectionViewCell
           return cell
       }
       else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthCollectionViewCell", for: indexPath) as! FourthCollectionViewCell
           return cell
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ViewController.headerId, for: indexPath)
        return header
    }
}

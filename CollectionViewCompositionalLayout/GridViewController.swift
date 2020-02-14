//
//  ViewController.swift
//  CollectionViewCompositionalLayout
//
//  Created by shiga on 14/02/20.
//  Copyright © 2020 shiga. All rights reserved.
//

import UIKit

struct Animal {
    let name: String
}

let animals = [
Animal(name: "lion"),
Animal(name: "tiger"),
Animal(name: "crocodile"),
Animal(name: "snake"),
Animal(name: "fox"),
Animal(name: "cat"),
Animal(name: "deer")
]


class GridViewController: UIViewController {

    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureHighierarchy()
    }

}


extension GridViewController {
    
    func createLayout() -> UICollectionViewLayout  {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func configureHighierarchy()  {
        collectionView  = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: GridCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
}


extension GridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifier, for: indexPath) as? GridCell else { fatalError("Could not create Cell")  }
        
        let animal = animals[indexPath.row]
        
        cell.imageView.image = UIImage(named: animal.name)
        
        return cell
    }
    
    
}

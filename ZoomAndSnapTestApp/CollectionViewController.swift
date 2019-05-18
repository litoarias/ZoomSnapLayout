//
//  CollectionViewController.swift
//  ZoomedCenterCell
//
//  Created by Lito Arias on 15/05/2019.
//  Copyright © 2019 MonnoApps. All rights reserved.
//

import UIKit
import ZoomSnapLayout

class CollectionViewController: UIViewController {
    
    weak var collectionView: UICollectionView!
    var collectionDataSource: CollectionDataSource?
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let guide = view.safeAreaLayoutGuide
        let topAnchor = guide.topAnchor
        let height = UIScreen.main.bounds.size.height
        let flowLayout = ZoomAndSnapFlowLayout(itemSize: CGSize(width: (height / 7) / 2, height: height / 7))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: height / 6),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ])
        
        self.collectionView = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let collectionView = collectionView else { fatalError() }
        collectionDataSource = CollectionDataSource(collectionView: collectionView)
        //collectionView.decelerationRate = .fast // uncomment if necessary
        collectionView.dataSource = collectionDataSource
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(CollectionLoaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerCell")
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.footerReferenceSize = CGSize(width: 200, height: 75)
//        }
        
    }
    
}

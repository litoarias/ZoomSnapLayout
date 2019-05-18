//
//  CollectionViewCell.swift
//  ZoomedCenterCell
//
//  Created by Lito Arias on 15/05/2019.
//  Copyright © 2019 MonnoApps. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CollectionLoaderCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    func setupCell() {
        addSubview(spinner)
//        NSLayoutConstraint.activate([
//            spinner.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//            spinner.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//            ])
        spinner.center = self.contentView.center
        spinner.startAnimating()
    }
}

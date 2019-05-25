//
//  CollectionDataSource.swift
//  ZoomedCenterCell
//
//  Created by Lito Arias on 15/05/2019.
//  Copyright © 2019 MonnoApps. All rights reserved.
//

import UIKit
import Foundation

enum LoadMoreStatus {
    case loading
    case finished
    case haveMore
}

class CollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        
    }
    
    var numberOfCells = 5
    var loadingStatus: LoadMoreStatus = .haveMore
    var firstFooterCellid = "footerCell"
    
    func reloadData() {
        numberOfCells = 10
        collectionView?.reloadData()
        if numberOfCells > 0 {
            collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
        }
    }
    
    @objc func loadMore() {
        if numberOfCells >= 40 {
            // here will show untill finished number
            loadingStatus = .finished
            collectionView?.reloadData()
            return
        }
        
        // Replace code with web service and append to data source
        _ = Timer.schedule(delay: 2) { timer in
            self.numberOfCells += 10
            self.collectionView?.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        if indexPath.row == numberOfCells - 1 {
            if loadingStatus == .haveMore {
                self.perform(#selector(loadMore), with: nil, afterDelay: 0)
            }
            if loadingStatus != .finished {
                let activityView = UIActivityIndicatorView(style: .gray)
                activityView.center = CGPoint(x:cell.contentView.frame.size.width * 1.2, y: cell.contentView.frame.size.height / 2)
                cell.contentView.addSubview(activityView)
                activityView.startAnimating()
            }
        }
        
        return cell
        
    }   
    
}


extension Timer {
    class func schedule(delay: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    class func schedule(repeatInterval interval: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
}

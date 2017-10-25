//
//  LJDiscoveryCell.swift
//  LiveProject
//
//  Created by liang on 2017/10/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJDiscoveryCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate lazy var vm: LJDiscoveryContentViewModel = LJDiscoveryContentViewModel()
    fileprivate var anchorData: [AnchorModel]?
    fileprivate var currentIndex : Int = 0
    
    var cellDidSelected : ((_ anchor : AnchorModel) -> ())?
    
    class func cellWithTableView(_ tableView : UITableView) -> LJDiscoveryCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(self)") as! LJDiscoveryCell
        
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vm.loadContentData {
            self.anchorData = Array(self.vm.anchorModels[self.currentIndex * 9..<(self.currentIndex + 1) * 9])
            self.collectionView.reloadData()
        }
    }
    
    func reloadData() {
        currentIndex += 1
        if currentIndex > 2 { currentIndex = 0 }
        anchorData = Array(vm.anchorModels[currentIndex * 9..<(currentIndex + 1) * 9])
        collectionView.reloadData()
    }

    
}

extension LJDiscoveryCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LJDiscoveryCollectionCell", for: indexPath) as! LJDiscoveryCollectionCell
        
        cell.anchor = anchorData![indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cellDidSelected = cellDidSelected {
            cellDidSelected(anchorData![indexPath.item])
        }
    }
}

class LJDiscoverContentViewLayout : UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        let itemMargin : CGFloat = 10
        let itemW = (collectionView!.bounds.width - 4 * itemMargin) / 3
        let itemH = collectionView!.bounds.height / 3
        itemSize = CGSize(width: itemW, height: itemH)
        
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        
        collectionView?.bounces = false
    }
}

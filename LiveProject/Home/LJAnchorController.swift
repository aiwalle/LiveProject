//
//  LJAnchorController.swift
//  LiveProject
//
//  Created by liang on 2017/8/2.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJAnchorController: UIViewController {

    var homeType : HomeType!
    
    fileprivate lazy var homeViewModel : LJHomeViewModel = LJHomeViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = LJWaterFallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.cols = 2
        layout.dataSource = self
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout:layout )
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: kAnchorControllerCellID)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
//        loadData(index: 0)
    }
}


extension LJAnchorController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
    
    fileprivate func loadData(index : Int) {
        homeViewModel.loadHomeData(type: homeType, index: index, finishedCallBack: {
            self.collectionView.reloadData()
        })
    }
}

extension LJAnchorController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return homeViewModel.anchorModels.count
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HomeViewCell.cellWithCollectionView(collectionView, indexPath: indexPath as NSIndexPath)
//        cell.anchorModel = homeViewModel.anchorModels[indexPath.item]
        return cell
    }
}

extension LJAnchorController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
}

extension LJAnchorController : LJWaterFallLayoutDataSource {
    func waterFallLayout(_ layout: LJWaterFallLayout, itemIndex: Int) -> CGFloat {
        return itemIndex % 2 == 0 ? kDeviceWidth * 2 / 3 : kDeviceWidth * 0.5
    }
}


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
        let collectionFrame = CGRect(x: 0, y: 0, width: kDeviceWidth, height: kDeviceHeight - kStatusBarHeight - kNavigationBarHeight - 44 - kTabBarHeight)
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout:layout )
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: kAnchorControllerCellID)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(index: 0)
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
//        return 0
        return homeViewModel.anchorModels.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HomeViewCell.cellWithCollectionView(collectionView, indexPath: indexPath as NSIndexPath)
        cell.anchorModel = homeViewModel.anchorModels[indexPath.item]
        if indexPath.item == homeViewModel.anchorModels.count - 1 {
            loadData(index: homeViewModel.anchorModels.count)
        }
        return cell
    }
}

extension LJAnchorController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = LJRoomController()
        roomVc.anchor = homeViewModel.anchorModels[indexPath.item]
        
        self.navigationController?.pushViewController(roomVc, animated: true)
    }
}

extension LJAnchorController : LJWaterFallLayoutDataSource {
    func waterFallLayout(_ layout: LJWaterFallLayout, itemIndex: Int) -> CGFloat {
        return itemIndex % 2 == 0 ? kDeviceWidth * 2 / 3 : kDeviceWidth * 0.5
    }
}


//
//  LJGiftController.swift
//  LiveProject
//
//  Created by liang on 2017/8/11.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

/*
 // 面向对象的网络请求
 giftViewModel.requestGiftData {
 print(self.giftViewModel.giftPackages.count)
 }
 
 
 // 面向协议的网络请求
 giftViewModel.requestData {
 print(self.giftViewModel.data.count)
 }
 
 */

class LJGiftController: UIViewController {

    fileprivate lazy var giftViewModel : LJGiftViewModel = LJGiftViewModel()
    
    fileprivate lazy var pageCv : LJPageCollectionView = {
        let collectionFrame = CGRect(x: 0, y: 80, width: self.view.bounds.width, height: 300)
        var style = LJPageStyle()
//        style.isShowBottomLine = true
        
        let layout = LJPageCollectionLayout()
        layout.rows = 2
        layout.cols = 4
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.lineMargin = 10
        layout.itemMargin = 10
        let pageCv = LJPageCollectionView(frame: collectionFrame, titles: ["热门", "高级", "豪华", "专属"], style: style, isTitleInTop: true, layout: layout)
        pageCv.registerNib(UINib(nibName: "GiftViewCell", bundle: nil), forCellWithReuseIdentifier: kPageControllerCellID)
        
        pageCv.dataSource = self
        return pageCv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
        
    }
}

extension LJGiftController {
    fileprivate func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        view.addSubview(pageCv)
    }
    
    fileprivate func loadData() {
        giftViewModel.requestData {
            self.pageCv.reloadData()
        }
    }
    
}

extension LJGiftController: LJPageCollectionViewDataSource {
    func numberOfSectionInPageCollectionView(_ pageCollectionView: LJPageCollectionView) -> Int {
        return giftViewModel.data.count
    }
    
    func pageCollectionView(_ pageCollectionView: LJPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftViewModel.data[section].list.count
    }
    
    func pageCollectionView(_ pageCollectionView: LJPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageControllerCellID, for: indexPath) as! GiftViewCell
        let model = giftViewModel.data[indexPath.section].list[indexPath.item]
        cell.giftModel = model
        return cell
    }
}

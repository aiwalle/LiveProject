//
//  LJGiftListView.swift
//  LiveProject
//
//  Created by liang on 2017/8/30.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

protocol LJGiftListViewDelegate : class {
    func giftListView(_ giftListView : LJGiftListView, giftModel : LJGiftModel)
}

class LJGiftListView: UIView, NibLoadable {
    
    @IBOutlet weak var giftView: UIView!
    
    @IBOutlet weak var sendGiftBtn: UIButton!
    
    weak open var delegate: LJGiftListViewDelegate?
    
    fileprivate var pageCv : LJPageCollectionView!
    fileprivate var currentIndexPath : IndexPath?
    fileprivate lazy var giftViewModel : LJGiftViewModel = LJGiftViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGiftView()
        loadData()
        
    }
}

extension LJGiftListView {
    fileprivate func setupGiftView() {
        var style = LJPageStyle()
        style.isShowBottomLine = true
        style.normalColor = .white
        
        let layout = LJPageCollectionLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.cols = 4
        layout.rows = 2
        layout.lineMargin = 5
        layout.itemMargin = 5
        
        var pageViewFrame = giftView.bounds
        pageViewFrame.size.width = kDeviceWidth
        pageCv = LJPageCollectionView(frame: pageViewFrame, titles: ["热门", "高级", "豪华", "专属"], style: style, isTitleInTop: true, layout: layout)
        pageCv.registerNib(UINib(nibName: "GiftViewCell", bundle: nil), forCellWithReuseIdentifier: kPageControllerCellID)
        
        pageCv.dataSource = self
        pageCv.delegate = self
        giftView.addSubview(pageCv)
    }
    
    fileprivate func loadData() {
        giftViewModel.requestData {
            self.pageCv.reloadData()
        }
    }
}


extension LJGiftListView: LJPageCollectionViewDataSource {
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

extension LJGiftListView: LJPageCollectionViewDelegate {
    func pageCollectionView(_ pageCollectionView: LJPageCollectionView, didSelectItemAt indexPath: IndexPath) {
        sendGiftBtn.isEnabled = true
        currentIndexPath = indexPath
    }
}


extension LJGiftListView {
    @IBAction func sendGiftBtnClick(_ sender: UIButton) {
        let giftPackage = giftViewModel.data[(currentIndexPath?.section)!]
        let giftModel = giftPackage.list[(currentIndexPath?.item)!]
        delegate?.giftListView(self, giftModel: giftModel)
        sender.isEnabled = false
    }
}

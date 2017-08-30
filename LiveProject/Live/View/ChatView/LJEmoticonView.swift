//
//  LJEmoticonView.swift
//  LiveProject
//
//  Created by liang on 2017/8/30.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJEmoticonView: UIView {

    
    var emoticonClickCallback : ((LJEmoticonModel) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LJEmoticonView {
    fileprivate func setupUI() {
        var style = LJPageStyle()
        style.isShowBottomLine = true
        
        let layout = LJPageCollectionLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.cols = 7
        layout.rows = 3
        layout.lineMargin = 0
        layout.itemMargin = 0
        
        let pageCv = LJPageCollectionView(frame: bounds, titles: ["普通", "粉丝专属"], style: style, isTitleInTop: true, layout: layout)
        
        pageCv.register(LJEmoticonViewCell.self, forCellWithReuseIdentifier: kEmoticonViewCellID)
        
        pageCv.dataSource = self
        pageCv.delegate = self
        addSubview(pageCv)
    }
}


extension LJEmoticonView : LJPageCollectionViewDataSource, LJPageCollectionViewDelegate {
    func numberOfSectionInPageCollectionView(_ pageCollectionView: LJPageCollectionView) -> Int {
        return LJEmoticonViewModel.shareInstance.packags.count
    }
    
    func pageCollectionView(_ pageCollectionView: LJPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = LJEmoticonViewModel.shareInstance.packags[section].emoticons.count
        
        return count
    }
    
    func pageCollectionView(_ pageCollectionView: LJPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = LJEmoticonViewCell.cellWithCollectionView(collectionView, indexPath: indexPath as NSIndexPath)
        
        cell.emoticon = LJEmoticonViewModel.shareInstance.packags[indexPath.section].emoticons[indexPath.item]
        return cell
    }
    
    func pageCollectionView(_ pageCollectionView: LJPageCollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoticon = LJEmoticonViewModel.shareInstance.packags[indexPath.section].emoticons[indexPath.item]
        
        if let emoticonClickCallback = emoticonClickCallback {
            emoticonClickCallback(emoticon)
        }
    }
}



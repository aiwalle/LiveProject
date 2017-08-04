//
//  LJPageCollectionView.swift
//  LiveProject
//
//  Created by liang on 2017/8/4.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit



protocol LJPageCollectionViewDataSource: class {
    func numberOfSectionInPageCollectionView(_ pageCollectionView : LJPageCollectionView) -> Int
    func pageCollectionView(_ pageCollectionView : LJPageCollectionView, numberOfItemsInSection section: Int) -> Int
    func pageCollectionView(_ pageCollectionView : LJPageCollectionView,_ collectionView : UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}


class LJPageCollectionView: UIView {
    
    weak open var dataSource: LJPageCollectionViewDataSource?

    
    
    fileprivate var titles : [String]
    fileprivate var style : LJPageStyle
    fileprivate var isTitleInTop : Bool
    
    
    fileprivate var titleView : LJTitleView!
    fileprivate var collectionView : UICollectionView!
    fileprivate var pageControl : UIPageControl!
    fileprivate var layout : LJPageCollectionLayout
    
    init(frame: CGRect, titles: [String], style: LJPageStyle, isTitleInTop: Bool, layout: LJPageCollectionLayout) {
        self.titles = titles
        self.style = style
        self.isTitleInTop = isTitleInTop
        self.layout = layout
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension LJPageCollectionView {
    func setupUI() {
        let titleY = isTitleInTop ? 0 : bounds.height - style.titleHeight
        let titleViewFrame = CGRect(x: 0, y: titleY, width: bounds.width, height: style.titleHeight)
        titleView = LJTitleView(frame: titleViewFrame, titles: self.titles, style: self.style)
        titleView.delegate = self
        
        addSubview(titleView)
        
        let pageH : CGFloat = 20.0
        let pageY = isTitleInTop ? bounds.height - pageH : bounds.height - pageH - titleViewFrame.size.height
        let pageControlFrame = CGRect(x: 0, y: pageY, width: bounds.width, height: pageH)
        pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        addSubview(pageControl)
        
        
        let collectionY = isTitleInTop ? style.titleHeight : 0
        let collectionH = bounds.height - style.titleHeight - pageControl.frame.size.height
        let collectionViewFrame = CGRect(x: 0, y: collectionY, width: bounds.width, height: collectionH)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.dataSource = self
        addSubview(collectionView)
        
        
        
        titleView.backgroundColor = UIColor.getRandomColor()
        pageControl.backgroundColor = UIColor.getRandomColor()
        collectionView.backgroundColor = UIColor.getRandomColor()
    }
}

extension LJPageCollectionView {
    open func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    open func registerNib(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    open func reloadData() {
        collectionView.reloadData()
    }
}

extension LJPageCollectionView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSectionInPageCollectionView(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.pageCollectionView(self, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.pageCollectionView(self, collectionView, cellForItemAt: indexPath)
    }
}

extension LJPageCollectionView : LJTitleViewDelegate {
    func titleView(_ titleView: LJTitleView, targetIndex: Int) {
        
    }
}

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

protocol LJPageCollectionViewDelegate: class {
    func pageCollectionView(_ pageCollectionView : LJPageCollectionView, didSelectItemAt indexPath: IndexPath)
}

class LJPageCollectionView: UIView {
    
    weak open var dataSource: LJPageCollectionViewDataSource?

    weak open var delegate: LJPageCollectionViewDelegate?
    
    fileprivate var titles : [String]
    fileprivate var style : LJPageStyle
    fileprivate var isTitleInTop : Bool
    fileprivate lazy var currentIndex : IndexPath = IndexPath(item: 0, section: 0)
    
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
        collectionView.delegate = self
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
        let sectionItemCounts = dataSource?.pageCollectionView(self, numberOfItemsInSection: section) ?? 0
        if section == 0 {
            pageControl.numberOfPages = (sectionItemCounts - 1) / (layout.cols * layout.rows) + 1
        }
        return sectionItemCounts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.pageCollectionView(self, collectionView, cellForItemAt: indexPath)
    }
}

extension LJPageCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pageCollectionView(self, didSelectItemAt: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewEndScroll()
        }
    }
    
    private func scrollViewEndScroll() {
        let point = CGPoint(x: layout.sectionInset.left + 1 + collectionView.contentOffset.x, y: layout.sectionInset.top + 1)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        
        if indexPath.section != currentIndex.section {
            let itemsCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: indexPath.section) ?? 0
            pageControl.numberOfPages = (itemsCount - 1) / (layout.cols * layout.rows) + 1
            titleView.setCurrentIndex(indexPath.section)
            currentIndex = indexPath
        }
        pageControl.currentPage = indexPath.item / (layout.cols * layout.rows)
    }
}

extension LJPageCollectionView : LJTitleViewDelegate {
    func titleView(_ titleView: LJTitleView, targetIndex: Int) {
        let indexPath = IndexPath(item: 0, section: targetIndex)
        // scrollTo 只能滚动到collectionView的contentSize，不可能超过滚动范围，所以如果再设置contentOffset就会有问题
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        // 调整间距偏移量，这里的代码是来解决👆的问题
        let itemsCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: targetIndex) ?? 0
        
        pageControl.numberOfPages = (itemsCount - 1) / (layout.cols * layout.rows) + 1
        pageControl.currentPage = 0
        currentIndex = indexPath
        if (targetIndex == collectionView.numberOfSections - 1) && itemsCount <= layout.cols * layout.rows{
            return
        }
        collectionView.contentOffset.x -= layout.sectionInset.left
    }
}

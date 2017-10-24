//
//  LJContentView.swift
//  LiveProject
//
//  Created by liang on 2017/7/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

protocol LJContentViewDelegate: class {
    func contentView(_ contentView: LJContentView, didEndScroll inIndex: Int)
    func contentView(_ contentView: LJContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat)
}

class LJContentView: UIView {
    weak var delegate: LJContentViewDelegate?
    
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    fileprivate var startOffset : CGFloat = 0
    fileprivate var isForbidDelegate : Bool = false
    // 如果闭包中用到当前对象的属性，那么self不能省略
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        return collectionView
    }()
    
    
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    

}

extension LJContentView {
    fileprivate func setupUI() {
        for childVc in childVcs {
            childVc.view.backgroundColor = .white
            parentVc.addChildViewController(childVc)
        }
        addSubview(collectionView)
    }
}

extension LJContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let childVc = self.childVcs[indexPath.item]
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

extension LJContentView : UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndScroll(scrollView)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // 这里有个bug，快速拖动标题会出现两个红色的
        scrollView.isScrollEnabled = false
    }
    
    func scrollViewDidEndScroll(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = true
        let index = collectionView.contentOffset.x / collectionView.bounds.width
        delegate?.contentView(self, didEndScroll: Int(index))
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        guard contentOffsetX != startOffset && !isForbidDelegate else {
            return
        }
        var sourceIndex = 0
        var targetIndex = 0
        var progress: CGFloat = 0
        let collectionWidth = collectionView.bounds.width
        if contentOffsetX > startOffset { // 左滑
            sourceIndex = Int(contentOffsetX / collectionWidth)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            progress = (contentOffsetX - startOffset) / collectionWidth
            if (contentOffsetX - startOffset) == collectionWidth {
                targetIndex = sourceIndex
            }
        } else {                          // 右滑
            targetIndex = Int(contentOffsetX / collectionWidth)
            sourceIndex = targetIndex + 1
            progress = (startOffset - contentOffsetX) / collectionWidth
        }
//        print("sourceIndex:\(sourceIndex) targetIndex:\(targetIndex) progress:\(progress)")
        
        delegate?.contentView(self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
}

extension LJContentView : LJTitleViewDelegate {
    func titleView(_ titleView: LJTitleView, targetIndex: Int) {
//        print(targetIndex)
        isForbidDelegate = true
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}


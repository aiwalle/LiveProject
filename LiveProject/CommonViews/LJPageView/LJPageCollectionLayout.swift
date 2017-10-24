//
//  LJPageCollectionLayout.swift
//  LiveProject
//
//  Created by liang on 2017/8/4.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJPageCollectionLayout: UICollectionViewLayout {
    var sectionInset : UIEdgeInsets = UIEdgeInsets.zero
    var itemMargin : CGFloat = 0
    var lineMargin : CGFloat = 0
    var cols : Int = 4
    var rows : Int = 2
    
    
    fileprivate lazy var maxWidth : CGFloat = 0
    fileprivate lazy var attributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
}

extension LJPageCollectionLayout {
    override func prepare() {
        
        guard let collectionView = collectionView else { return }
        let sections = collectionView.numberOfSections
        
        let itemWidth = (collectionView.bounds.size.width - sectionInset.left - sectionInset.right - itemMargin * (CGFloat(cols) - 1)) / CGFloat(cols)
        let itemHeight = (collectionView.bounds.size.height - sectionInset.top - sectionInset.bottom - lineMargin * (CGFloat(rows) - 1)) / CGFloat(rows)
        var totalPage : Int = 0
        for section in 0..<sections {
            let items = collectionView.numberOfItems(inSection: section)
            for item in 0..<items {
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                // 在当前section的第几页
                let pagesInSection = item / (cols * rows)
                // 当前页的第几个
                let currentIndex = item % (cols * rows)
                
                let itemX = sectionInset.left + CGFloat(currentIndex % cols) * (itemMargin + itemWidth) + CGFloat(pagesInSection + totalPage) * collectionView.bounds.size.width
                
                let itemY = sectionInset.top + CGFloat(currentIndex / cols) * (lineMargin + itemHeight)
                attribute.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight)
                attributes.append(attribute)
            }
            totalPage += (items - 1) / (rows * cols) + 1
        }
        maxWidth = CGFloat(totalPage) * collectionView.bounds.size.width
    }
}

extension LJPageCollectionLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

extension LJPageCollectionLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: maxWidth, height: 0)
    }
}

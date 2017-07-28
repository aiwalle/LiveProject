//
//  LJWaterFallLayout.swift
//  LiveProject
//
//  Created by liang on 2017/7/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJWaterFallLayout: UICollectionViewFlowLayout {
    fileprivate lazy var attributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxHeight : CGFloat = self.sectionInset.top + self.sectionInset.bottom
}

extension LJWaterFallLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        
        // 获取cell对应的attributes
        let cellCount = collectionView.numberOfItems(inSection: 0)
        
        let colNumber = 2
        let itemW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(colNumber) - 1) * minimumInteritemSpacing) / CGFloat(colNumber)
        
        var heights : [CGFloat] = Array(repeating: sectionInset.top, count: colNumber)
        
        for i in 0..<cellCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let itemH = arc4random_uniform(150) + 50
            let minH = heights.min()!
            let minIndex = heights.index(of: minH)!
            
            let itemX = sectionInset.left + (minimumInteritemSpacing + itemW) * CGFloat(minIndex)
            let itemY = minH + minimumLineSpacing
            
            attribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: CGFloat(itemH))
            attributes.append(attribute)
            heights[minIndex] = attribute.frame.maxY
        }
        maxHeight = heights.max()!
    }
}

extension LJWaterFallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

extension LJWaterFallLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxHeight + sectionInset.bottom)
    }
}

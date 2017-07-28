//
//  LJWaterFallLayout.swift
//  LiveProject
//
//  Created by liang on 2017/7/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

protocol LJWaterFallLayoutDataSource : class {
    func waterFallLayout(_ layout : LJWaterFallLayout, itemIndex : Int) -> CGFloat
}

class LJWaterFallLayout: UICollectionViewFlowLayout {
    var cols : Int = 2
    weak var dataSource : LJWaterFallLayoutDataSource?
    fileprivate lazy var attributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxHeight : CGFloat = self.sectionInset.top + self.sectionInset.bottom
    fileprivate lazy var heights : [CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
}

extension LJWaterFallLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        
        // 获取cell对应的attributes --> 一个cell对应一个attribute
        let cellCount = collectionView.numberOfItems(inSection: 0)
        
        let colNumber = cols
        let itemW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(colNumber) - 1) * minimumInteritemSpacing) / CGFloat(colNumber)
        
        for i in attributes.count..<cellCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            guard let itemH = dataSource?.waterFallLayout(self, itemIndex: i) else {
                fatalError("请设置数据源")
            }

            let minH = heights.min()!
            let minIndex = heights.index(of: minH)!
            
            let itemX = sectionInset.left + (minimumInteritemSpacing + itemW) * CGFloat(minIndex)
            let itemY = minH
            
            attribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: CGFloat(itemH))
            attributes.append(attribute)
            heights[minIndex] = attribute.frame.maxY + minimumLineSpacing
        }
        maxHeight = heights.max()! - minimumLineSpacing
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

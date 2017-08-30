//
//  LJEmoticonViewCell.swift
//  LiveProject
//
//  Created by liang on 2017/8/30.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJEmoticonViewCell: UICollectionViewCell {
    
    fileprivate var iconImageView : UIImageView = UIImageView()
    
    var emoticon : LJEmoticonModel? {
        didSet {
            iconImageView.image = UIImage(named: emoticon!.emoticonName)
        }
    }
    
    class func cellWithCollectionView(_ collectionView : UICollectionView, indexPath : NSIndexPath) -> LJEmoticonViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEmoticonViewCellID, for: indexPath as IndexPath) as! LJEmoticonViewCell
        cell.setupUI()
        return cell
    }
}

extension LJEmoticonViewCell {
    fileprivate func setupUI() {
        self.contentView.addSubview(iconImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRect(x: (self.bounds.width - 24) * 0.5, y: (self.bounds.height - 24) * 0.5, width: 24, height: 24)
    }
}

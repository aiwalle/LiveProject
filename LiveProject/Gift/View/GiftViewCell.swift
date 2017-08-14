//
//  GiftViewCell.swift
//  LiveProject
//
//  Created by liang on 2017/8/14.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class GiftViewCell: UICollectionViewCell {
    @IBOutlet weak var giftImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var giftModel : LJGiftModel? {
        didSet {
            giftImageView.setImage(giftModel?.img2, "room_btn_gift")
            titleLabel.text = giftModel?.subject
            priceLabel.text = "\(giftModel?.coin ?? 0)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

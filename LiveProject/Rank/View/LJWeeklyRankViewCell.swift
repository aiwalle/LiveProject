//
//  LJWeeklyRankViewCell.swift
//  LiveProject
//
//  Created by liang on 2017/10/27.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJWeeklyRankViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var giftNameLabel: UILabel!
    
    @IBOutlet weak var giftNumLabel: UILabel!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    var weekly : LJWeeklyModel? {
        didSet {
            iconImageView.setImage(weekly?.giftAppImg)
            giftNameLabel.text = weekly?.giftName
            giftNumLabel.text = "本周获得 x\(weekly?.giftNum ?? 0)个"
            nickNameLabel.text = weekly?.nickname
        }
        
    }
        

    
    
}

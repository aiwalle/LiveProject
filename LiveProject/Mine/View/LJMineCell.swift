//
//  LJMineCell.swift
//  LiveProject
//
//  Created by liang on 2017/10/24.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJMineCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    @IBOutlet weak var contentLabelCons: NSLayoutConstraint!
    
    class func cellWithTableView(_ tableView : UITableView) -> LJMineCell {
        // 这里如何通过类名来获取Identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(self)") as! LJMineCell
        
        return cell
    }
    
    var itemModel : LJSettingsItemModel? {
        didSet {
            guard let itemModel = itemModel else {
                return
            }
            itemModel.iconName == "" ? (iconImageView.isHidden = true) : (iconImageView.image = UIImage(named: itemModel.iconName))
            
            contentLabelCons.constant = itemModel.iconName == "" ? -15 : 10
            
            contentLabel.text = itemModel.contentText
            
            switch itemModel.accessoryType {
            case .arrow:
                onSwitch.isHidden = true
                hintLabel.isHidden = true
            case .arrowHint:
                onSwitch.isHidden = true
                hintLabel.isHidden = false
                hintLabel.text = itemModel.hintText
            case .onswitch:
                onSwitch.isHidden = false
                hintLabel.isHidden = true
                arrowImageView.isHidden = true
            }
            
            
        }
    }
    
    
}

//
//  LJChatContentCell.swift
//  LiveProject
//
//  Created by liang on 2017/8/29.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJChatContentCell: UITableViewCell {

    var contentLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(contentLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentLabel.frame = CGRect(x: 20, y: 5, width: self.bounds.width - 40, height: self.bounds.height - 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}

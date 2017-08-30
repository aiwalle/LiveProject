//
//  NibLoadable.swift
//  LiveProject
//
//  Created by liang on 2017/8/9.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit


protocol NibLoadable {
    
}

extension NibLoadable where Self : UIView {
    static func loadFromNib(_ nibName : String? = nil) -> Self {
        let nib = nibName ?? "\(self)"
        return Bundle.main.loadNibNamed(nib, owner: nil, options: nil)?.first as! Self
    }
}

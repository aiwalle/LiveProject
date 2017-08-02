//
//  BaseModel.swift
//  LiveProject
//
//  Created by liang on 2017/8/2.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

//
//  LJGiftPackage.swift
//  LiveProject
//
//  Created by liang on 2017/8/11.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJGiftPackage: BaseModel{
    var t : Int = 0
    var title : String = ""
    var list : [LJGiftModel] = [LJGiftModel]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list" {
            if let listArray = value as? [[String : Any]] {
                for listDict in listArray {
                    list.append(LJGiftModel(dict: listDict))
                }
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

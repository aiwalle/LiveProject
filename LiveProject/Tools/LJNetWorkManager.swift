//
//  LJNetWorkManager.swift
//  LiveProject
//
//  Created by liang on 2017/8/3.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class LJNetWorkManager {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping(_ result : Any) -> ())  {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.error!)
                return
            }
            finishedCallBack(result)
        }
    }
}



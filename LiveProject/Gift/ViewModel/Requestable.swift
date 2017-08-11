//
//  Requestable.swift
//  LiveProject
//
//  Created by liang on 2017/8/11.
//  Copyright © 2017年 liang. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable {
    var URLString : String { get }
    var type : MethodType { get }
    var parameters : [String : Any] { get }
    
    // 关联类型
    associatedtype ResultData
    var data : ResultData { get }
    func parseResult(_ result : Any)
}

extension Requestable {
    func requestData(_ complection : @escaping() -> Void)  {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.error!)
                return
            }
            self.parseResult(result)
            complection()
        }
    }
}

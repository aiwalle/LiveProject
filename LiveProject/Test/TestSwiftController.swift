//
//  TestSwiftController.swift
//  LiveProject
//
//  Created by liang on 2017/7/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class TestSwiftController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 可选类型
//        var arr : Array<String> = Array()
//        var name : Optional<String> = nil
//        name = "string"
//        
//        // Optional("string")
//        //        print(name)
//        // 对可选类型进行解包
//        // 强制解包
//        //        print(name!)
//        if let name = name {
//            print(name)
//        }
//        
//        
//        //        let url : URL? = URL(string: "http://www.baidu.com")
//        if let url = URL(string: "http://www.baidu.com") {
//            var request : URLRequest? = URLRequest(url: url)
//        }
//        
//        
        
        
        
        view.backgroundColor = .white
        
        let emoView = EmoticonView.loadFromNib()
        
        view.addSubview(emoView)
        
        let gift = GiftView.loadFromNib()
        view.addSubview(gift)
        
        // 协议规定了遵守的类型，因此这里报错
        //        let person = Person.loadFromNib()
    }

    
    
}

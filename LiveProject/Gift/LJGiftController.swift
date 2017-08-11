//
//  LJGiftController.swift
//  LiveProject
//
//  Created by liang on 2017/8/11.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJGiftController: UIViewController {

    fileprivate lazy var giftViewModel : LJGiftViewModel = LJGiftViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 面向对象的网络请求
//        giftViewModel.requestGiftData { 
////            self.giftViewModel
//            print(self.giftViewModel.giftPackages.count)
//        }
        
        
        // 面向协议的网络请求
        giftViewModel.requestData { 
            print(self.giftViewModel.data.count)
        }
        // 8
        
    }

    

}

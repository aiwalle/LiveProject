//
//  LJCarouselViewModel.swift
//  LiveProject
//
//  Created by liang on 2017/10/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJCarouselViewModel {
    lazy var carousels : [LJCarouselModel] = [LJCarouselModel]()
    
    func loadCarouselData(_ completion : @escaping () -> ()) {
        LJNetWorkManager.requestData(.get, URLString: "http://qf.56.com/home/v4/getBanners.ios") { (result : Any) in
            guard let resultDic = result as? [String : Any] else {
                return
            }
            
            guard let messageDic = resultDic["message"] as? [String : Any] else {
                return
            }
            
            guard let banners = messageDic["banners"] as? [[String : Any]] else {
                return
            }
            for dict in banners {
                self.carousels.append(LJCarouselModel(dict: dict))
            }
            
            completion()
            
        }
    }
}

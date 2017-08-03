//
//  UIImageView-Extension.swift
//  LiveProject
//
//  Created by liang on 2017/8/3.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ URLString : String?, _ placeHolderName : String? = nil) {
        guard let URLString = URLString else {
            return
        }
        guard let url = URL(string : URLString) else {
            return
        }
        guard let placeHolderName = placeHolderName else {
            kf.setImage(with: url)
            return
        }
        kf.setImage(with: url, placeholder: UIImage(named: placeHolderName))
    }
}

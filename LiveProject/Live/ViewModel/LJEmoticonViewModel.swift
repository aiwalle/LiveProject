//
//  LJEmoticonViewModel.swift
//  LiveProject
//
//  Created by liang on 2017/8/30.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJEmoticonViewModel {
    static let shareInstance : LJEmoticonViewModel = LJEmoticonViewModel()
    lazy var packags : [LJEmoticonPackage] = [LJEmoticonPackage]()
    
    
    init() {
        packags.append(LJEmoticonPackage(plistName: "QHNormalEmotionSort.plist"))
        packags.append(LJEmoticonPackage(plistName: "QHSohuGifSort.plist"))
    }
}

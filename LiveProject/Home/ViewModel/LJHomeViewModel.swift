//
//  LJHomeViewModel.swift
//  LiveProject
//
//  Created by liang on 2017/8/3.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJHomeViewModel {
    lazy var anchorModels = [AnchorModel]()
}

extension LJHomeViewModel {
    func loadHomeData(type : HomeType, index : Int, finishedCallBack : @escaping() -> ()) {
        
        LJNetWorkManager.requestData(.get, URLString: "http://qf.56.com/home/v4/moreAnchor.ios", parameters: ["type" : type.type, "index" : index, "size" : 48], finishedCallBack: {(result) -> Void in
            guard let resultDict = result as? [String : Any] else { return }
            guard let messageDict = resultDict["message"] as? [String : Any] else { return }
            
            // 上面的转换都是字典，这个转换出来是数组，注意看有两个方括号
            guard let dataArray = messageDict["anchors"] as? [[String : Any]] else { return }
            for (index, dict) in dataArray.enumerated() {
                
                let anchor = AnchorModel(dict: dict)
                anchor.isEvenIndex = index % 2 == 0
                self.anchorModels.append(anchor)
            }
            finishedCallBack()
        })
    }
        
}

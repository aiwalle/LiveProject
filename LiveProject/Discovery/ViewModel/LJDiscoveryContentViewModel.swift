//
//  LJDiscoveryContentViewModel.swift
//  LiveProject
//
//  Created by liang on 2017/10/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJDiscoveryContentViewModel: LJHomeViewModel {
    
}

extension LJDiscoveryContentViewModel {
    func loadContentData(_ complection : @escaping () -> ()) {
        LJNetWorkManager.requestData(.get, URLString: "http://qf.56.com/home/v4/guess.ios", parameters: ["count" : 27], finishedCallBack: { (result : Any) in
            
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let msgDict = resultDict["message"] as? [String : Any] else { return }
            
            guard let dataArray = msgDict["anchors"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.anchorModels.append(AnchorModel(dict: dict))
            }
            
            complection()
        })
    }
}

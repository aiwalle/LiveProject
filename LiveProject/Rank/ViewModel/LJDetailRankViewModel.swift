//
//  LJDetailRankViewModel.swift
//  LiveProject
//
//  Created by liang on 2017/10/26.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJDetailRankViewModel {
    lazy var rankModels : [LJRankModel] = [LJRankModel]()
}

extension LJDetailRankViewModel {
    func loadDetailRankData(_ type : LJRankType, _ complection : @escaping () -> ()) {
        let URLString = "http://qf.56.com/rank/v1/\(type.typeName).ios"
        let parameters = ["pageSize" : 30, "type" : type.typeNum]
        LJNetWorkManager.requestData(.get, URLString: URLString, parameters: parameters, finishedCallBack: { result in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let msgDict = resultDict["message"] as? [String : Any] else { return }
            
            guard let dataArray = msgDict[type.typeName] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.rankModels.append(LJRankModel(dict: dict))
            }
            
            complection()
        })
    }
}

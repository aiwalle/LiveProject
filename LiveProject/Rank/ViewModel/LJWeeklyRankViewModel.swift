//
//  LJWeeklyRankViewModel.swift
//  LiveProject
//
//  Created by liang on 2017/10/27.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJWeeklyRankViewModel {
    lazy var weeklyRanks : [[LJWeeklyModel]] = [[LJWeeklyModel]]()
    
    
}

extension LJWeeklyRankViewModel {
    func loadWeeklyRankData(_ rankType: LJRankType, _ completetion: @escaping () -> ()) {
        let URLString = "http://qf.56.com/activity/star/v1/rankAll.ios"
        let signature = rankType.typeNum == 1 ? "b4523db381213dde637a2e407f6737a6" : "d23e92d56b1f1ac6644e5820eb336c3e"
        let ts = rankType.typeNum == 1 ? "1480399365" : "1480414121"
        let parameters : [String : Any] = ["imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056", "pageSize" : 30, "signature" : signature, "ts" : ts, "weekly" : rankType.typeNum - 1]
        
        LJNetWorkManager.requestData(.get, URLString: URLString, parameters: parameters) { (result: Any) in
            guard let resultDic = result as? [String: Any] else { return }
            guard let msgDict = resultDic["message"] as? [String : Any] else { return }
            if let anchorDataArray = msgDict["anchorRank"] as? [[String : Any]] {
                self.addDataToWeeklyRanks(anchorDataArray)
            }
            if let fansDataArray = msgDict["fansRank"] as? [[String : Any]] {
                self.addDataToWeeklyRanks(fansDataArray)
            }
            completetion()
        }
    }
    
    private func addDataToWeeklyRanks(_ dataArray : [[String : Any]]) {
        var ranks = [LJWeeklyModel]()
        for dict in dataArray {
            ranks.append(LJWeeklyModel(dict: dict))
        }
        weeklyRanks.append(ranks)
    }
}

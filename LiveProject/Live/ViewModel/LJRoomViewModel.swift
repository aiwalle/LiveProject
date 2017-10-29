//
//  LJRoomViewModel.swift
//  LiveProject
//
//  Created by liang on 2017/10/27.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJRoomViewModel {
    lazy var liveURL : String = ""
}

extension LJRoomViewModel {
    func loadLiveURL(_ roomid: Int, _ userId: String, _ completion: @escaping () -> ()) {
        let URLString = "http://qf.56.com/play/v2/preLoading.ios"
        let parameters : [String : Any] = ["imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056",
                                           "roomId" : roomid,
                                           "signature" : "f69f4d7d2feb3840f9294179cbcb913f",
                                           "userId" : userId]
        
        LJNetWorkManager.requestData(.get, URLString: URLString, parameters: parameters) { (result: Any) in
            guard let resultDic = result as? [String: Any] else { return }
            guard let messageDic = resultDic["message"] as? [String: Any] else { return }
            guard let requestUrl = messageDic["rUrl"] as? String else { return }
            self.loadOnliveURL(requestUrl, completion)
            
        }
    }
    
    fileprivate func loadOnliveURL(_ onliveURL: String, _ completion: @escaping () -> ()) {
        LJNetWorkManager.requestData(.get, URLString: onliveURL) { (result: Any) in
            guard let resultDic = result as? [String: Any] else { return }
            guard let liveURL = resultDic["url"] as? String else { return }
            self.liveURL = liveURL
            completion()
            
        }
    }
    
    
}

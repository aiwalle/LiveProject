//
//  LJGiftContainerView.swift
//  LiveProject
//
//  Created by liang on 2017/9/2.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

private let kChannelCount = 2
private let kChannelViewH : CGFloat = 40
private let kChannelMargin : CGFloat = 10

class LJGiftContainerView: UIView {

    fileprivate lazy var channelViews : [LJGiftChannelView] = [LJGiftChannelView]()
    fileprivate lazy var cacheGiftModels : [LJGiftAnimationModel] = [LJGiftAnimationModel]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LJGiftContainerView {
    fileprivate func setupUI() {
        let width : CGFloat = frame.width
        let height : CGFloat = kChannelViewH
        let x : CGFloat = 0
        for i in 0..<kChannelCount {
            let y : CGFloat = (height + kChannelMargin) * CGFloat(i)
            let channelView = LJGiftChannelView.loadFromNib()
            channelView.frame = CGRect(x: x, y: y, width: width, height: height)
            channelView.alpha = 0.0
            addSubview(channelView)
            channelView.delegate = self
            channelViews.append(channelView)
            
        }
    }
}


extension LJGiftContainerView {
    func showGiftModel(_ giftModel : LJGiftAnimationModel) {
        if let channelView = checkUsingChanelView(giftModel) {
            channelView.addOnceGiftAnimationToCache()
            return
        }
        
        if let channelView = checkIdleChannelView() {
            channelView.giftModel = giftModel
            channelView.performAnimation()
            return
        }
        cacheGiftModels.append(giftModel)
    }
}


extension LJGiftContainerView {
    // 判断当前giftModel对应的view是否在做动画
    fileprivate func checkUsingChanelView(_ giftModel : LJGiftAnimationModel) -> LJGiftChannelView? {
        for channelView in channelViews {
            if let channelModel = channelView.giftModel {
                if channelModel.isEqual(giftModel) && channelView.status != .endAnimating {
                    return channelView
                }
            }
        }
        return nil
    }
    
    // 检查看当前是否有闲置的channelView
    fileprivate func checkIdleChannelView() -> LJGiftChannelView? {
        for channelView in channelViews {
            if channelView.status == .idle {
                return channelView
            }
        }
        return nil
    }
}

extension LJGiftContainerView : LJGiftChannelViewDelegate {
    func giftAnimationDidCompletion(channelView: LJGiftChannelView) {
        if cacheGiftModels.count > 0 {
            let giftModel = cacheGiftModels.first!
            cacheGiftModels.removeFirst()
            showGiftModel(giftModel)
            for cacheModel in cacheGiftModels.reversed() {
                if cacheModel.isEqual(giftModel) {
                    cacheGiftModels.remove(at: cacheGiftModels.index(of: cacheModel)!)
                    channelView.addOnceGiftAnimationToCache()
                }
            }
        }
    }
}







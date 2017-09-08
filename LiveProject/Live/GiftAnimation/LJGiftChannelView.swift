//
//  LJGiftChannelView.swift
//  LiveProject
//
//  Created by liang on 2017/9/2.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

private let kShowChannelDuration : TimeInterval = 0.25
private let kHiddenChannelDelay : TimeInterval = 3.0

protocol LJGiftChannelViewDelegate : class{
    func giftAnimationDidCompletion(channelView : LJGiftChannelView)
}

enum LJGiftChannelState {
    case idle
    case animating
    case willEnd
    case endAnimating
}



class LJGiftChannelView: UIView, NibLoadable {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: LJDigitLabel!
    
    weak var delegate : LJGiftChannelViewDelegate?
    var status : LJGiftChannelState = .idle
    
    fileprivate var cacheNumber : Int = 0
    fileprivate var currentNumber : Int = 0
    
    var giftModel : LJGiftAnimationModel? {
        didSet {
            guard let giftModel = giftModel else {
                return
            }
            
            iconImageView.image = UIImage(named: giftModel.senderURL)
            senderLabel.text = giftModel.senderName
            giftDescLabel.text = "送出礼物：【\(giftModel.giftName)】"
            giftImageView.setImage(giftModel.giftURL)
            
        }
    }
    
    
}

extension LJGiftChannelView {
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
        
    }
}

extension LJGiftChannelView {
    // 将当前view显示到屏幕的过程
    func performAnimation() {
        self.status = .animating
        UIView.animate(withDuration: kShowChannelDuration, animations: {
            self.frame.origin.x = 0
            self.alpha = 1.0
        }) { (isFinished) in
            self.performDigitAnimation()
        }
    }
    
    // 等同于点击了赠送礼物
    // 为何这里不直接调用上面的方法？由于该方法不是针对从没有在屏幕上出现的view
    func addOnceGiftAnimationToCache() {
        if self.status == .animating {
            cacheNumber += 1
        } else {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            performDigitAnimation()
        }
    }
}

extension LJGiftChannelView {
    // 显示数字跳动的效果，显示完成后等待3s执行移除到屏幕外的操作
    fileprivate func performDigitAnimation() {
        digitLabel.alpha = 1.0
        currentNumber += 1
        digitLabel.text = "X\(currentNumber)"
        
        digitLabel.showDigitAnimation(kShowChannelDuration) {
            if self.cacheNumber > 0 {
                self.cacheNumber -= 1
                self.performDigitAnimation()
            } else {
                self.status = .willEnd
                self.perform(#selector(self.performEndAnimation), with: self, afterDelay: kShowChannelDuration)
            }
        }
    }
    
    
    // 消失动画
    @objc fileprivate func performEndAnimation() {
        self.status = .endAnimating
        
        UIView.animate(withDuration: kShowChannelDuration, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0.0
        }) { (isFinished) in
            self.giftModel = nil
            self.digitLabel.alpha = 0.0
            self.frame.origin.x = -self.frame.width
            self.currentNumber = 0
            self.status = .idle
            
            self.delegate?.giftAnimationDidCompletion(channelView: self)
        }
    }
}


//
//  LJAttributeStringGenerator.swift
//  LiveProject
//
//  Created by liang on 2017/8/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
import Kingfisher
class LJAttributeStringGenerator {
    
}


extension LJAttributeStringGenerator {
    class func generateRoom(isJoin : Bool, userName : String) -> NSAttributedString {
        let roomMsg = isJoin ? "join" : "leave"
        let message = "\(userName)\(roomMsg) Room"
        let range = NSRange(location: 0, length: userName.characters.count)
        let attributeString = NSMutableAttributedString(string: message)
        attributeString.setAttributes([NSForegroundColorAttributeName : UIColor.red], range: range)
        
        return attributeString
    }
    
    
    // lj: 哈哈哈[抠鼻]呵呵呵呵[大笑]123
    class func generateChatMessage(_ userName : String,_ chatMessage : String,_ fontHeight : CGFloat) -> NSAttributedString {
        
        let message = "\(userName):\(chatMessage)"
        
        let range = NSRange(location: 0, length: userName.characters.count)
        let attributeString = NSMutableAttributedString(string: message)
        attributeString.setAttributes([NSForegroundColorAttributeName : UIColor.red], range: range)
        
        let pattern = "\\[.*?\\]"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attributeString
        }
        let results = regex.matches(in: message, options: [], range: NSRange(location: 0, length: message.characters.count))
        
        for i in (0..<results.count).reversed() {
            let result = results[i]
            let emoticonname = (message as NSString).substring(with: result.range)
            
            guard let image = UIImage(named: emoticonname) else {
                continue
            }
            
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -4, width: fontHeight, height: fontHeight)
            let imageAttr = NSAttributedString(attachment: attachment)
            attributeString.replaceCharacters(in: result.range, with: imageAttr)
            
        }
        
        return attributeString
    }
    
    class func generateGiftMessage(_ userName : String,_ giftname : String,_ giftURL : String,_ fontHeight : CGFloat) -> NSAttributedString {
        let message = "\(userName)give\(giftname)"
        
        let range = NSRange(location: 0, length: userName.characters.count)
        let attributeString = NSMutableAttributedString(string: message)
        attributeString.setAttributes([NSForegroundColorAttributeName : UIColor.red], range: range)
        
        let giftRange = (message as NSString).range(of: giftname)
        attributeString.setAttributes([NSForegroundColorAttributeName : UIColor.yellow], range: giftRange)
        
        guard let image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: giftURL) else {
            return attributeString
        }
        
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -4, width: fontHeight, height: fontHeight)
        let imageAttr = NSAttributedString(attachment: attachment)
        attributeString.append(imageAttr)
        
        return attributeString
    }
    
    
    
    
    
    
    
    
}

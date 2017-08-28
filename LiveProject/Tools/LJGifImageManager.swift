//
//  LJGifImageManager.swift
//  LiveProject
//
//  Created by liang on 2017/8/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
import ImageIO
class LJGifImageManager {
  
    
}


extension LJGifImageManager {
    
    class func loadLocalGifWithImageName(imageView : UIImageView ,imageName : String) {
        guard let filePath = Bundle.main.url(forResource: imageName, withExtension: "gif") else {
            print("file not exist")
            return
        }

        guard let imageData = NSData(contentsOf: filePath) else { return }
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil)  else { return }
        let count = CGImageSourceGetCount(imageSource)
        
        var images = [UIImage]()
        var totalDuration : TimeInterval = 0
        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            images.append(image)
            
            guard let propertyDic = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as Dictionary? else { continue }
            guard let gifDic = propertyDic[kCGImagePropertyGIFDictionary]   as? NSDictionary else { continue }
            guard let duration = gifDic[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            
            totalDuration += duration.doubleValue
        }
        
        imageView.animationImages = images
        imageView.animationDuration = totalDuration
        imageView.animationRepeatCount = 1
        
        imageView.startAnimating()
    }
}

//
//  LJRoomController.swift
//  LiveProject
//
//  Created by liang on 2017/8/29.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJRoomController: UIViewController {
    @IBOutlet weak var bgImageView: UIImageView!

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var roomNumberLabel: UILabel!
    
    var anchor : AnchorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupUI()
    }

}

// MARK:- 设置UI
extension  LJRoomController {
    fileprivate func setupUI() {
        setupBlurView()
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        // 下面这行代码是由于xib中获取到的frame不准确而添加的
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    
}









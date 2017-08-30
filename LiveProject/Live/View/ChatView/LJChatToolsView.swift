//
//  LJChatToolsView.swift
//  LiveProject
//
//  Created by liang on 2017/8/30.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJChatToolsView: UIView {

    fileprivate lazy var inputTextField : UITextField = UITextField(frame: CGRect(x: kChatToolsViewMargin, y: kChatToolsViewMargin, width: kDeviceWidth - kChatToolsViewMargin * 3 - 60, height: self.bounds.height - kChatToolsViewMargin * 2))
    
    fileprivate lazy var sendMsgBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: self.inputTextField.frame.maxX + kChatToolsViewMargin, y: kChatToolsViewMargin, width: 60, height: self.bounds.height - kChatToolsViewMargin * 2)
        btn.setTitle("发送", for: UIControlState.normal)
        btn.backgroundColor = UIColor.orange
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        btn.addTarget(self, action: #selector(sendMsgBtnClick(_ :)), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var emoticonBtn : UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: kEmoticonBtnWidth, height: kEmoticonBtnWidth)
        btn.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        btn.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        btn.addTarget(self, action: #selector(emoticonBtnClick(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    fileprivate lazy var emoticonView : LJEmoticonView = {
        let emoticon = LJEmoticonView(frame: CGRect(x: 0, y: 0, width: kDeviceWidth, height: KEmoticonViewHeight))
        return emoticon
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LJChatToolsView {
    fileprivate func setupUI() {
        addSubview(inputTextField)
        addSubview(sendMsgBtn)
        
        inputTextField.rightView = emoticonBtn
        inputTextField.rightViewMode = .always
        inputTextField.allowsEditingTextAttributes = true
    }
}

extension LJChatToolsView {
    @objc fileprivate func sendMsgBtnClick(_ sender : UIButton) {
        
    }
    
    @objc fileprivate func emoticonBtnClick(_ btn : UIButton) {
        btn.isSelected = !btn.isSelected
        
        let range = inputTextField.selectedTextRange
        inputTextField.resignFirstResponder()
        inputTextField.inputView = inputTextField.inputView == nil ? emoticonView : nil
        inputTextField.becomeFirstResponder()
        inputTextField.selectedTextRange = range
    }
}

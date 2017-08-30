//
//  LJChatToolsView.swift
//  LiveProject
//
//  Created by liang on 2017/8/30.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

protocol LJChatToolsViewDelegate : class {
    func chatToolsView(_ chatToolsView: LJChatToolsView, message : String)
}


class LJChatToolsView: UIView {

    weak open var delegate : LJChatToolsViewDelegate?
    
    
    lazy var inputTextField : UITextField = UITextField()
    
    fileprivate lazy var sendMsgBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        
        btn.setTitle("发送", for: UIControlState.normal)
        btn.backgroundColor = UIColor.orange
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        btn.addTarget(self, action: #selector(sendMsgBtnClick(_ :)), for: UIControlEvents.touchUpInside)
        btn.isEnabled = false
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        inputTextField.frame = CGRect(x: kChatToolsViewMargin, y: kChatToolsViewMargin, width: kDeviceWidth - kChatToolsViewMargin * 3 - 60, height: self.bounds.height - kChatToolsViewMargin * 2)
        
        sendMsgBtn.frame = CGRect(x: self.inputTextField.frame.maxX + kChatToolsViewMargin, y: kChatToolsViewMargin, width: 60, height: self.bounds.height - kChatToolsViewMargin * 2)
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
        inputTextField.addTarget(self, action: #selector(textFieldDidEdit(_:)), for: UIControlEvents.editingChanged)
        
        
        emoticonView.emoticonClickCallback = { [weak self] emoticon in
            if emoticon.emoticonName == "delete-n" {
                self?.inputTextField.deleteBackward()
                return
            }
            
            guard let range = self?.inputTextField.selectedTextRange else { return }
            self?.inputTextField.replace(range, withText: emoticon.emoticonName)
            
        }
    }
}

extension LJChatToolsView {
    @objc fileprivate func textFieldDidEdit(_ textField : UITextField) {
        sendMsgBtn.isEnabled = textField.text?.characters.count != 0
    }
    
    
    @objc fileprivate func sendMsgBtnClick(_ sender : UIButton) {
        let message = inputTextField.text!
        inputTextField.text = ""
        sender.isEnabled = false
        delegate?.chatToolsView(self, message: message)
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

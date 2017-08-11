//
//  LoginViewController.swift
//  LiveProject
//
//  Created by liang on 2017/8/9.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class DataEntryTextField: UITextField, Shakeable {

}

class LoginButton: UIButton, Shakeable {

}

class FlashLabel: UILabel, Shakeable, Flashable {
    
}

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: DataEntryTextField!

    @IBOutlet weak var pwdField: DataEntryTextField!
    
    @IBOutlet weak var loginBtn: LoginButton!
    
    @IBOutlet weak var flashLabel: FlashLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        automaticallyAdjustsScrollViewInsets = false
        
    }


    @IBAction func loginBtnClick(_ sender: UIButton) {
        
        emailField.shake()
        pwdField.shake()
        loginBtn.shake()
        flashLabel.flash()
        flashLabel.shake()
    }
    
}

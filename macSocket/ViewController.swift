//
//  ViewController.swift
//  macSocket
//
//  Created by liang on 2017/8/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var openBtn: NSButton!

    @IBOutlet weak var closeBtn: NSButton!
    
    @IBOutlet weak var statusLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func serveOpen(_ sender: NSButton) {
        statusLabel.stringValue = "服务器正在运行"
    }

    @IBAction func serveClose(_ sender: NSButton) {
        statusLabel.stringValue = "服务器停止运行"
        
    }

}


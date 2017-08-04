//
//  LJRoomController.swift
//  LiveProject
//
//  Created by liang on 2017/8/3.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJRoomController: UIViewController {

    
    var anchor : AnchorModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let searchBar = UISearchBar(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        view.addSubview(searchBar)
        
    }

    

}

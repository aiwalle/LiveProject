//
//  LJHomeController.swift
//  LiveProject
//
//  Created by liang on 2017/7/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJHomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupContentView()
    }


}

extension LJHomeController {
    fileprivate func setupNavigationBar() {
        let logoImage = UIImage(named: "home-logo1")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .done, target: nil, action: nil)
        
        let searchImage = UIImage(named: "search_btn_follow")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchImage, style: .done, target: nil, action: nil)
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
        
        let searchField = searchBar.value(forKeyPath: "_searchField") as? UITextField
        searchField?.textColor = .white
        
        navigationController?.navigationBar.barTintColor = .black
        
    }
    
    fileprivate func setupContentView() {
        let homeTypes = loadTypeData()
        var style = LJPageStyle()
        style.isScrollEnable = true
        style.isNeedScale = true
//        style.isShowCoverView = true
        let pageFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kDeviceWidth, height: kDeviceHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)
        
        let titles = homeTypes.map({$0.title})
        var childVcs = [LJAnchorController]()
        for type in homeTypes {
            let anchorVc = LJAnchorController()
            anchorVc.homeType = type
            childVcs.append(anchorVc)
        }
        
        let pageView = LJPageView(frame: pageFrame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
    }
    
    fileprivate func loadTypeData() -> [HomeType] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String : Any]]
        var tempArr = [HomeType]()
        for dict in dataArray {
            tempArr.append(HomeType(dict: dict))
        }
        return tempArr
    }
    
    
    
    
}

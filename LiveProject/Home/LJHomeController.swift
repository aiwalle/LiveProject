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
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupContentView()
//        setupPageView()
    }

    fileprivate func setupPageView() {
        automaticallyAdjustsScrollViewInsets = false
        let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        //        let titles = ["推荐", "游戏推荐", "娱乐推", "天天"]
        let titles = ["推荐", "游戏推荐", "娱乐推", "哈哈哈哈哈荐","呵呵呵", "科技推", "娱乐推荐推荐"]
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = ViewController()
            vc.view.backgroundColor = UIColor.getRandomColor()
            childVcs.append(vc)
        }
        var style = LJPageStyle()
        style.isShowBottomLine = true
        style.isShowCoverView = true
        style.isScrollEnable = true
        style.isNeedScale = true
        let pageView = LJPageView(frame: pageFrame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
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

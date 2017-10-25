//
//  LJTabBarController.swift
//  LiveProject
//
//  Created by liang on 2017/7/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbarItems()
        
        
        setupChildVcs()
        
    }


}


extension LJTabBarController {
    fileprivate func setupTabbarItems() {
        var normalAttribute : [String : Any] = [String : Any]()
        normalAttribute[NSForegroundColorAttributeName] = UIColor.black
        normalAttribute[NSFontAttributeName] = UIFont.systemFont(ofSize: 12)
        
        var selectedAttribute : [String : Any] = [String : Any]()
        selectedAttribute[NSForegroundColorAttributeName] = UIColor(hexString: "ca9b68")
        
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes(normalAttribute, for: .normal)
        item.setTitleTextAttributes(selectedAttribute, for: .selected)
        
    }
    
    fileprivate func setupChildVcs() {
        addChildVc(LJHomeController(), title: "首页", normalImage: "live-n", selectedImage: "live-p")
        addChildVc(LJRankController(), title: "排行", normalImage: "ranking-n", selectedImage: "ranking-p")
//        addChildVc(LJDiscoveryController(), title: "发现", normalImage: "found-n", selectedImage: "found-p")
        
        addChildVcWithStoryboard("LJDiscoveryController", title: "发现", normalImage: "found-n", selectedImage: "found-p")
        addChildVc(LJMineController(), title: "我的", normalImage: "mine-n", selectedImage: "mine-p")
    }
    // 通过代码创建Controller
    fileprivate func addChildVc(_ childVc : UIViewController, title : String, normalImage : String, selectedImage: String) {
        let nav = LJNavigationCotroller(rootViewController: childVc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: normalImage)
        nav.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        addChildViewController(nav)
    }
    // 通过Storyboard创建Controller
    fileprivate func addChildVcWithStoryboard(_ storyName : String, title : String, normalImage : String, selectedImage: String) {
        
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        let nav = LJNavigationCotroller(rootViewController: childVc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: normalImage)
        nav.tabBarItem.selectedImage = UIImage(named: selectedImage)
        addChildViewController(nav)
        
    }
    
}

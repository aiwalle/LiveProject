//
//  LJMineController.swift
//  LiveProject
//
//  Created by liang on 2017/7/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJMineController: LJBaseMineController {
    
    fileprivate lazy var headerView : LJMineHeaderView = LJMineHeaderView.loadFromNib()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension LJMineController {
    override func setupUI() {
        super.setupUI()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        
        headerView.frame = CGRect(x: 0, y: 0, width: kDeviceWidth, height: 200)
        tableView.tableHeaderView = headerView
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kDeviceWidth, height: 0))
//        footerView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        tableView.tableFooterView = footerView
    }
    
    override func setupData() {
        let section0Model = LJSettingsSectionModel()
        section0Model.sectionHeaderHeight = 5
        
        let section0Item = LJSettingsItemModel(icon: "mine_follow", content: "我的关注")
        section0Model.itemArray.append(section0Item)
        let section1Item = LJSettingsItemModel(icon: "mine_money", content: "我的帆币")
        section0Model.itemArray.append(section1Item)
        let section2Item = LJSettingsItemModel(icon: "mine_fanbao", content: "我的帆宝")
        section0Model.itemArray.append(section2Item)
        let section3Item = LJSettingsItemModel(icon: "mine_bag", content: "我的背包")
        section3Item.accessoryType = .arrowHint
        section3Item.hintText = "查看礼物"
        section0Model.itemArray.append(section3Item)
        let section4Item = LJSettingsItemModel(icon: "mine_money", content: "现金红包")
        section0Model.itemArray.append(section4Item)
        
        sections.append(section0Model)
        
        
        let section1Model = LJSettingsSectionModel()
        section1Model.sectionHeaderHeight = 5
        
        let section1Item0 = LJSettingsItemModel(icon: "mine_edit", content: "编辑资料")
        section1Model.itemArray.append(section1Item0)
        let section1Item1 = LJSettingsItemModel(icon: "mine_set", content: "设置")
        section1Model.itemArray.append(section1Item1)
        
        sections.append(section1Model)
        
        
        tableView.reloadData()
    }
    
    
}


extension LJMineController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        if indexPath.section == 1 && indexPath.item == 1 {
            let settingsVc = LJSettingsViewController()
            navigationController?.pushViewController(settingsVc, animated: true)
        }
    }
}

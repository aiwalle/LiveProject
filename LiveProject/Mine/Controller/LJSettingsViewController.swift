//
//  LJSettingsViewController.swift
//  LiveProject
//
//  Created by liang on 2017/10/24.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJSettingsViewController: LJBaseMineController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"

        
    }
}

extension LJSettingsViewController {
    override func setupData() {
        // 1.第一组数据
        let section0Model = LJSettingsSectionModel()
        section0Model.sectionHeaderHeight = 5
        
        let section0Item = LJSettingsItemModel(content: "开播提醒")
        section0Item.accessoryType = .onswitch
        section0Model.itemArray.append(section0Item)
        let section1Item = LJSettingsItemModel(content: "移动流量提醒")
        section1Item.accessoryType = .onswitch
        section0Model.itemArray.append(section1Item)
        let section2Item = LJSettingsItemModel(content: "网络环境优化")
        section2Item.accessoryType = .onswitch
        section0Model.itemArray.append(section2Item)
        
        sections.append(section0Model)
        
        // 2.第二组数据
        let section1Model = LJSettingsSectionModel()
        section1Model.sectionHeaderHeight = 5
        
        let section1Item0 = LJSettingsItemModel(content: "绑定手机", hint : "未绑定")
        section1Item0.accessoryType = .arrowHint
        section1Model.itemArray.append(section1Item0)
        let section1Item1 = LJSettingsItemModel(content: "意见反馈")
        section1Model.itemArray.append(section1Item1)
        let section1Item2 = LJSettingsItemModel(content: "直播公约")
        section1Model.itemArray.append(section1Item2)
        let section1Item3 = LJSettingsItemModel(content: "关于我们")
        section1Model.itemArray.append(section1Item3)
        let section1Item4 = LJSettingsItemModel(content: "我要好评")
        section1Model.itemArray.append(section1Item4)
        
        sections.append(section1Model)
        
        // 3.刷新表格
        tableView.reloadData()
    }
}

extension LJSettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(LJSettingsViewController(), animated: true)
    }
    
}

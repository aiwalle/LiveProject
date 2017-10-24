//
//  LJBaseMineController.swift
//  LiveProject
//
//  Created by liang on 2017/10/24.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

private let kLJMineCell = "LJMineCell"

class LJBaseMineController: UIViewController {

    lazy var tableView : UITableView = UITableView()
    
    lazy var sections : [LJSettingsSectionModel] = [LJSettingsSectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
        
    }

}

extension LJBaseMineController {
    func setupUI() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: kLJMineCell, bundle: nil), forCellReuseIdentifier: kLJMineCell)
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 55
        
    }
    
    func setupData() {
        
    }
}

extension LJBaseMineController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LJMineCell.cellWithTableView(tableView)
        let section = sections[indexPath.section]
        cell.itemModel = section.itemArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].sectionHeaderHeight
    }
}

//
//  LJDetailRankViewController.swift
//  LiveProject
//
//  Created by liang on 2017/10/26.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
let kLJDetailRankViewCell = "LJDetailRankViewCell"
class LJDetailRankViewController: LJSubrankViewController {
    var rankType : LJRankType
    lazy var tableView: UITableView = UITableView()
    
    fileprivate lazy var detailRankVM : LJDetailRankViewModel = LJDetailRankViewModel()
    
    init(rankType : LJRankType) {
        self.rankType = rankType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

    

}

extension LJDetailRankViewController {
    fileprivate func setupUI() {
        tableView.frame = CGRect(x: 0, y: 0, width: kDeviceWidth, height: kDeviceHeight-kNavigationBarHeight-kStatusBarHeight-kTabBarHeight-35)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = 50
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        tableView.register(UINib(nibName: "LJDetailRankViewCell", bundle: nil), forCellReuseIdentifier: kLJDetailRankViewCell)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func loadData() {
        detailRankVM.loadDetailRankData(rankType) {
            self.tableView.reloadData()
        }
    }
}

extension LJDetailRankViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailRankVM.rankModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLJDetailRankViewCell) as! LJDetailRankViewCell
        cell.rankNum = indexPath.row
        cell.rankModel = detailRankVM.rankModels[indexPath.row]
        return cell
    }
}

//
//  LJWeeklyRankViewController.swift
//  LiveProject
//
//  Created by liang on 2017/10/26.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

let kLJWeeklyRankViewCell = "LJWeeklyRankViewCell"

class LJWeeklyRankViewController: LJDetailRankViewController {

    fileprivate lazy var weeklyRankVM: LJWeeklyRankViewModel = LJWeeklyRankViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "LJWeeklyRankViewCell", bundle: nil), forCellReuseIdentifier: kLJWeeklyRankViewCell)
        
    }
    
    override init(rankType: LJRankType) {
        super.init(rankType: rankType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LJWeeklyRankViewController {
    override func loadData() {
        weeklyRankVM.loadWeeklyRankData(rankType) {
            self.tableView.reloadData()
        }
    }
}

extension LJWeeklyRankViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return weeklyRankVM.weeklyRanks.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyRankVM.weeklyRanks[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLJWeeklyRankViewCell) as! LJWeeklyRankViewCell
        cell.weekly = weeklyRankVM.weeklyRanks[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "主播周星榜" : "富豪周星榜"
    }
}




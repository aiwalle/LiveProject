//
//  LJDiscoveryController.swift
//  LiveProject
//
//  Created by liang on 2017/7/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit


class LJDiscoveryController: UITableViewController {

    fileprivate lazy var carouselView: LJCarouselView = LJCarouselView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }
   
}

extension LJDiscoveryController {
    fileprivate func setupUI() {
        
        setupHeaderView()
        setupFooterView()
        
        tableView.rowHeight = kDeviceWidth * 1.4
    }
    
    fileprivate func setupHeaderView() {
        let carouselViewH = kDeviceWidth * 0.4
        carouselView.frame = CGRect(x: 0, y: 0, width: kDeviceWidth, height: carouselViewH)
        tableView.tableHeaderView = carouselView
    }
    
    fileprivate func setupFooterView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kDeviceWidth, height: 80))
        
        let btn = UIButton(frame: CGRect.zero)
        btn.frame.size = CGSize(width: kDeviceWidth * 0.5, height: 40)
        btn.center = CGPoint(x: kDeviceWidth * 0.5, y: 40)
        btn.setTitle("换一换", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.orange.cgColor
        btn.layer.borderWidth = 0.5
        btn.addTarget(self, action: #selector(switchGuessAnchor), for: .touchUpInside)
        
        footerView.addSubview(btn)
        footerView.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        tableView.tableFooterView = footerView
    }
    
    fileprivate func setupSectionHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kDeviceWidth, height: 40))
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: kDeviceWidth, height: 40))
        headerLabel.textAlignment = .center
        headerLabel.text = "猜你喜欢"
        headerLabel.textColor = UIColor.orange
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    
    @objc private func switchGuessAnchor() {
        let cell = tableView.visibleCells.first as? LJDiscoveryCell
        cell?.reloadData()
        let offset = CGPoint(x: 0, y: kDeviceWidth * 0.4 - 64)
        tableView.setContentOffset(offset, animated: true)
    }
}


extension LJDiscoveryController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LJDiscoveryCell.cellWithTableView(tableView)
        cell.cellDidSelected = { (anchor : AnchorModel) in
            let liveVc = LJRoomController()
            liveVc.anchor = anchor
            self.navigationController?.pushViewController(liveVc, animated: true)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setupSectionHeaderView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}







//
//  LJChatContentView.swift
//  LiveProject
//
//  Created by liang on 2017/8/29.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJChatContentView: UIView {

    fileprivate lazy var messages : [NSAttributedString] = [NSAttributedString]()
    
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = 40
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.register(LJChatContentCell.self, forCellReuseIdentifier: kChatContentCellID)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addChildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = self.bounds
    }
    
    func insertMsg(_ message : NSAttributedString) {
        messages.append(message)
        tableView.reloadData()
        let indexPatch = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPatch, at: UITableViewScrollPosition.middle, animated: true)
    }
}

extension LJChatContentView {
    fileprivate func addChildView() {
        self.addSubview(tableView)
    }
}

extension LJChatContentView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatContentCellID, for: indexPath) as! LJChatContentCell
        cell.contentLabel.attributedText = messages[indexPath.row]
        return cell
    }
}

















//
//  LJPageTestController.swift
//  LiveProject
//
//  Created by liang on 2017/10/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJPageTestController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addPageCollectionView()
        
    }
    
    func addPageCollectionView() {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        
        
        let collectionFrame = CGRect(x: 0, y: 80, width: view.bounds.width, height: 300)
        let titles = ["推荐", "游戏推荐", "娱乐推", "天天"]
        var style = LJPageStyle()
        style.isShowBottomLine = true
        
        let layout = LJPageCollectionLayout()
        layout.rows = 4
        layout.cols = 8
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.lineMargin = 10
        layout.itemMargin = 10
        let pageCv = LJPageCollectionView(frame: collectionFrame, titles: titles, style: style, isTitleInTop: true, layout: layout)
        pageCv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPageControllerCellID)
        pageCv.dataSource = self
        view.addSubview(pageCv)
    }

}

extension LJPageTestController: LJPageCollectionViewDataSource {
    func numberOfSectionInPageCollectionView(_ pageCollectionView: LJPageCollectionView) -> Int {
        return 4
    }
    
    func pageCollectionView(_ pageCollectionView: LJPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 100 : 50
    }
    
    func pageCollectionView(_ pageCollectionView: LJPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageControllerCellID, for: indexPath)
        cell.backgroundColor = UIColor.getRandomColor()
        return cell
    }
}

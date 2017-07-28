//
//  ViewController.swift
//  LiveProject
//
//  Created by liang on 2017/7/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
private let kViewControllerCellID = "kViewControllerCellID"

class ViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = {
        let layout = LJWaterFallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout:layout )
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kViewControllerCellID)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupPageView()
        
        
        view.addSubview(collectionView)
        
        
    }
    
    
    
    
    
    
    
    fileprivate func setupPageView() {
        automaticallyAdjustsScrollViewInsets = false
        let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        //        let titles = ["推荐", "游戏推荐", "娱乐推", "天天"]
        let titles = ["推荐", "游戏推荐", "娱乐推", "哈哈哈哈哈荐","呵呵呵", "科技推", "娱乐推荐推荐"]
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
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


extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kViewControllerCellID, for: indexPath)
        cell.backgroundColor = UIColor.getRandomColor()
        return cell
    }
}

extension ViewController : UICollectionViewDelegate {
    
}


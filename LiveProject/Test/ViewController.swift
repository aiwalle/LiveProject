//
//  ViewController.swift
//  LiveProject
//
//  Created by liang on 2017/7/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
private let kViewControllerCellID = "kViewControllerCellID"

@IBOutlet weak var sd: UIButton!
@IBOutlet weak var ss: UIButton!
class ViewController: UIViewController {
    fileprivate var itemCount = 15
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = LJWaterFallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.cols = 2
        layout.dataSource = self
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
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kViewControllerCellID, for: indexPath)
        cell.backgroundColor = UIColor.getRandomColor()
        return cell
    }
}

extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            itemCount += 30
            collectionView.reloadData()
        }
    }
}

extension ViewController : LJWaterFallLayoutDataSource {
    func waterFallLayout(_ layout: LJWaterFallLayout, itemIndex: Int) -> CGFloat {
        let screenW = UIScreen.main.bounds.width
//        return itemIndex % 2 == 0 ? screenW * 2 / 3 : screenW * 0.5
        return CGFloat(arc4random_uniform(150) + 80)
    }
}


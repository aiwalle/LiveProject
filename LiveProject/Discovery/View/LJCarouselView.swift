//
//  LJCarouselView.swift
//  LiveProject
//
//  Created by liang on 2017/10/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

private let kCarouselViewCellID = "kCarouselViewCellID"

class LJCarouselView: UIView, NibLoadable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    fileprivate lazy var carouselVM: LJCarouselViewModel = LJCarouselViewModel()

    fileprivate var updateTimer : Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(LJCarouselViewCell.self, forCellWithReuseIdentifier: kCarouselViewCellID)
        
        addTimer()
        
        carouselVM.loadCarouselData {
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = self.carouselVM.carousels.count
            let startIndexPath = IndexPath(item: self.carouselVM.carousels.count * 100, section: 0)
            self.collectionView.scrollToItem(at: startIndexPath, at: .left, animated: true)
        }
    }
}

// timer
extension LJCarouselView {
    fileprivate func addTimer() {
        updateTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(updateTimer!, forMode: .commonModes)
        
    }
    fileprivate func removeTimer() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    @objc fileprivate func scrollToNext() {
        let offset = collectionView.contentOffset.x + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
}

extension LJCarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselVM.carousels.count * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCarouselViewCellID, for: indexPath) as! LJCarouselViewCell
        
        cell.carouselModel = carouselVM.carousels[indexPath.item % carouselVM.carousels.count]
        
        return cell
    }
}

extension LJCarouselView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (self.carouselVM.carousels.count > 0 ? self.carouselVM.carousels.count : 4)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        addTimer()
    }
}

class LJCarouseViewLayout : UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        itemSize = collectionView!.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
    }
}

class LJCarouselViewCell : UICollectionViewCell {
    
    var carouselModel : LJCarouselModel? {
        didSet {
            imageView.setImage(carouselModel?.picUrl, "placeholder")
        }
    }
    
    fileprivate lazy var imageView : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
}

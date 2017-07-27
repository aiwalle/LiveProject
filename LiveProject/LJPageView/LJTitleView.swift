//
//  LJTitleView.swift
//  LiveProject
//
//  Created by liang on 2017/7/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJTitleView: UIView {
    var titles : [String]
    var style : LJPageStyle
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    
    init(frame: CGRect, titles: [String], style: LJPageStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension LJTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        setupTitleLabels()
    }
    
    private func setupTitleLabels() {
        var titleLabels: [UILabel] = [UILabel]()
        // 即便利title和index
        for (i, title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
            titleLabel.font = style.titleFont
            
            scrollView.addSubview(titleLabel)
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabels.append(titleLabel)
        }
        
        let labelH: CGFloat = style.titleHeight
        let labelY: CGFloat = 0
        var labelW: CGFloat = bounds.width / CGFloat(titles.count)
        var labelX: CGFloat = 0
        for (i, titleLabel) in titleLabels.enumerated() {
            if style.isScrollEnable {   // 可以滚动
                labelW = (titleLabel.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : style.titleFont], context: nil).width
                labelX = i == 0 ? style.titleMargin * 0.5 : (style.titleMargin + titleLabels[i-1].frame.maxX)
            } else {    // 不可以滚动
                labelX = labelW * CGFloat(i)
                
            }
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        }
        if style.isScrollEnable {
            scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + style.titleMargin * 0.5, height: 0)
        }
    }
}

extension LJTitleView {
    func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        guard let selectedLabel = tapGes.view as? UILabel else {
            return
        }
        print(selectedLabel.tag)
    }
}




//
//  LJTitleView.swift
//  LiveProject
//
//  Created by liang on 2017/7/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
// 加了class表示该协议只能被类遵守
protocol LJTitleViewDelegate : class {
    func titleView(_ titleView : LJTitleView, targetIndex : Int)
}

class LJTitleView: UIView {
    weak var delegate : LJTitleViewDelegate?
    
    fileprivate var titles : [String]
    fileprivate var style : LJPageStyle
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    fileprivate var currentIndex : Int = 0
    fileprivate lazy var normalRGB : (CGFloat, CGFloat, CGFloat) = self.style.normalColor.getRGBValue()
    fileprivate lazy var selectRGB : (CGFloat, CGFloat, CGFloat) = self.style.selectColor.getRGBValue()
    fileprivate lazy var deltaRGB : (CGFloat, CGFloat, CGFloat) = {
        let deltaR = self.selectRGB.0 - self.normalRGB.0
        let deltaG = self.selectRGB.1 - self.normalRGB.1
        let deltaB = self.selectRGB.2 - self.normalRGB.2
        return (deltaR, deltaG, deltaB)
    }()
    
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
        
        // 即便利title和index
        for (i, title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
            titleLabel.font = style.titleFont
            titleLabel.isUserInteractionEnabled = true
            
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
        guard let targetLabel = tapGes.view as? UILabel else {
            return
        }
        guard targetLabel.tag != currentIndex else {
            return
        }
//        print(targetLabel)
        let sourceLabel = titleLabels[currentIndex]
        sourceLabel.textColor = style.normalColor
        targetLabel.textColor = style.selectColor
        currentIndex = targetLabel.tag
        
        adjustLabelPosition()
        
        delegate?.titleView(self, targetIndex: currentIndex)
    }
    
    fileprivate func adjustLabelPosition() {
        let targetLabel = titleLabels[currentIndex]
        var offsetX = targetLabel.center.x - scrollView.bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        let maxOffsetX = scrollView.contentSize.width - scrollView.bounds.width
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension LJTitleView : LJContentViewDelegate {
    
    func contentView(_ contentView: LJContentView, didEndScroll inIndex: Int) {
        currentIndex = inIndex
        
        adjustLabelPosition()
    }
    
    func contentView(_ contentView: LJContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        sourceLabel.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * progress, g: selectRGB.1 - deltaRGB.1 * progress, b: selectRGB.2 - deltaRGB.2 * progress)
        targetLabel.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * progress, g: normalRGB.1 + deltaRGB.1 * progress, b: normalRGB.2 + deltaRGB.2 * progress)
    }
    

}


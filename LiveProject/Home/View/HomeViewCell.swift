//
//  HomeViewCell.swift
//  LiveProject
//
//  Created by liang on 2017/8/3.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    
    var anchorModel : AnchorModel? {
        didSet {
            albumImageView.setImage(anchorModel!.isEvenIndex ? anchorModel?.pic74 : anchorModel?.pic51, "home_pic_default")
            liveImageView.isHidden = anchorModel?.live == 0
            nickNameLabel.text = anchorModel?.name
            onlinePeopleLabel.setTitle("\(anchorModel?.focus ?? 0)", for: .normal)
        }
    }
    
    
    fileprivate lazy var albumImageView: UIImageView = {
        let albumImageView = UIImageView()
        albumImageView.image = UIImage(named: "home_pic_default")
        
        return albumImageView
    }()
    
    fileprivate lazy var liveImageView: UIImageView = {
        let liveImageView = UIImageView()
        liveImageView.image = UIImage(named: "home_icon_live")
        return liveImageView
    }()
    
    fileprivate lazy var nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        
        nickNameLabel.textColor = .white
        nickNameLabel.font = UIFont.systemFont(ofSize: 12.0)
        nickNameLabel.text = "这里是一只猪的直播间"
        return nickNameLabel
    }()
    
    fileprivate lazy var onlinePeopleLabel: UIButton = {
        let onlinePeopleLabel = UIButton()
        
        onlinePeopleLabel.setImage(UIImage(named: "home_icon_people"), for: .normal)
        onlinePeopleLabel.setTitle("4311", for: .normal)
        onlinePeopleLabel.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
        return onlinePeopleLabel
    }()
    
    class func cellWithCollectionView(_ collectionView : UICollectionView, indexPath : NSIndexPath) -> HomeViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAnchorControllerCellID, for: indexPath as IndexPath) as! HomeViewCell
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumImageView.frame = self.bounds
        let liveImageSize = UIImage(named: "home_icon_live")?.size
        liveImageView.frame = CGRect(x: self.bounds.width - kAnchorCellSubviewMargin - liveImageSize!.width, y: kAnchorCellSubviewMargin, width: liveImageSize!.width, height: liveImageSize!.height)
        nickNameLabel.frame = CGRect(x: kAnchorCellSubviewMargin, y: self.bounds.height - 30, width: self.bounds.width * 0.6, height: 22)
        onlinePeopleLabel.frame = CGRect(x: self.nickNameLabel.frame.maxX + kAnchorCellSubviewMargin, y: self.bounds.height - 30, width: self.bounds.width * 0.3, height: 22)
        onlinePeopleLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        
    }
}

extension HomeViewCell {
    fileprivate func setupUI() {
        contentView.addSubview(albumImageView)
        contentView.addSubview(liveImageView)
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(onlinePeopleLabel)
    }
}

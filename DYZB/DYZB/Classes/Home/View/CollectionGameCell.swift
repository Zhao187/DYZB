//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/7.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    // MARK: 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: 定义模型属性
    var baseGame : BaseGameModel?
    {
        didSet{
            titleLabel.text = baseGame?.tag_name
            
            let iconUrl = URL(string: baseGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconUrl, placeholder: Image(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

}

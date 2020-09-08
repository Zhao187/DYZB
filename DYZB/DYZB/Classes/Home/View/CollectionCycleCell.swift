//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/7.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: 定义模型属性
    var cycleModel : CycleModel?
    {
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL!), placeholder: Image(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }

}

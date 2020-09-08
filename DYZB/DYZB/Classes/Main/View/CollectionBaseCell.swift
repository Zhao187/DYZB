//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/7.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    
    // MARK: - 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
     
     @IBOutlet weak var onlineBtn: UIButton!
     
     @IBOutlet weak var nickNameLabel: UILabel!
    
    //MARK: - 定义模型
    var anchor:AnchorModel?{
        didSet{
            guard let anchor = anchor else {return}
            //1.取出在线人数显示文字
            var onlineStr :String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }
            else{
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            
            iconImageView.kf.setImage(with:  ImageResource(downloadURL: URL(string: anchor.vertical_src)!))
        }
    }
}

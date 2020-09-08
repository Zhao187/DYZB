//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/5.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var iconView: UIImageView!
    
    
    @IBOutlet weak var moreBtn: UIButton!
    
    var group:AnchorGroup?{
        didSet{
            titleView.text = group?.tag_name
            if group?.tag_name == "热门" || group?.tag_name == "颜值"{
                iconView.image = UIImage(named:group?.small_icon_url ?? "")
            }
            else
            {
                var iconUrl = group?.small_icon_url ?? ""
                if iconUrl.count == 0 {
                    iconUrl = "home_header_normal"
                }
                
                iconView.kf.setImage(with:  ImageResource(downloadURL: URL(string:iconUrl)!), placeholder: Image(named: "home_header_normal"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
}

// MARK: - 从xib中快速创建类方法
extension CollectionHeaderView
{
    class func collectionHeaderView() -> CollectionHeaderView
    {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}

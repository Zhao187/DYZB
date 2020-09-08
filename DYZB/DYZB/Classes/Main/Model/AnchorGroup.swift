//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/6.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

@objcMembers
class AnchorGroup: BaseGameModel {
    
    ///     该组中对应的房间信息
    var room_list :[[String:NSObject]]?
    {
        didSet{
            guard let room_list = room_list else {return}
            
            for dict in room_list {
                let anchor = AnchorModel(dict: dict)
                anchors.append(anchor)
            }
        }
    }
    
    ///    组显示的图标
    var small_icon_url:String = ""
    
    
    lazy var anchors:[AnchorModel] = [AnchorModel]()
}

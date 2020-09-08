//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/5.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    
    //MARK: - 控件属性
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //MARK: - 定义模型属性
    override var anchor: AnchorModel?{
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
    
}

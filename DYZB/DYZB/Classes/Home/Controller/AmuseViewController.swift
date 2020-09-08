//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/7.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
}

//MARK: - 发送网络请求
extension AmuseViewController
{
    override func loadData() {
        //1. 给父类中viewModel中赋值
        baseVM = amuseVM
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}



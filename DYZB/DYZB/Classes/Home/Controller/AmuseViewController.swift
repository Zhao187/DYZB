//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/7.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let KMenuViewH:CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var menuView:AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -KMenuViewH, width: KScreenW, height: KMenuViewH)
        return menuView
    }()
}

//MARK: - 设置UI界面
extension AmuseViewController{
    override func setupUI(){
        super.setupUI()
        
        //将菜单View添加到控制器的view中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: KMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 发送网络请求
extension AmuseViewController
{
    override func loadData() {
        //1. 给父类中viewModel中赋值
        baseVM = amuseVM
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            //请求数据完成
            self.loadDataFinished()
        }
    }
}



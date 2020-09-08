//
//  FunnyViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/8.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let KTopMargin:CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
   
    //MARK: - 懒加载属性
    fileprivate lazy var funnyVM = FunnyViewModel()
}

extension FunnyViewController
{
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsets(top: KTopMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController
{
    override func loadData() {
        //给父类中viewmodel赋值
        baseVM = self.funnyVM
        
        //2.请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            //数据请求完成
            self.loadDataFinished()
        }
    }
}

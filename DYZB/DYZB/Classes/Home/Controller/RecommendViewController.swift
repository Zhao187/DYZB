//
//  RecommendControllerViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/5.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let KItemMargin:CGFloat = 10
private let KItemW = (KScreenW - 3 * KItemMargin) / 2
private let KNormalItemH = KItemW * 3 / 4
private let KPrettyItemH = KItemW * 4 / 3
private let KHeaderViewH:CGFloat = 50
private let KCycleViewH = KScreenH * 2 / 8
private let KGameViewH:CGFloat = 90

private let KNormalCellID = "KNormalCellID"
private let KPrettyCellID = "KPrettyCellID"
private let KHeaderViewID = "KHeaderViewID"

class RecommendViewController: UIViewController {
    
    //MARK: 懒加载
    private lazy var recommendModel:RecommendViewModel = RecommendViewModel()
    
    private lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: KNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = KItemMargin
        layout.headerReferenceSize = CGSize(width: KScreenW, height: KHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView
    }()

    private lazy var cycleView:RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y:-(KCycleViewH + KGameViewH), width: KScreenW, height: KCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView:RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y:-KGameViewH , width: KScreenW, height: KGameViewH)
        return gameView
    }()
    
    //MARK: 系统毁掉函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        //发送网络请求
        loadData()
    }
}

//MARK: 设置UI界面内容
extension RecommendViewController
{
    private func setupUI(){
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        //设置内边距
        collectionView.contentInset = UIEdgeInsets(top: KCycleViewH + KGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension RecommendViewController
{
    private func loadData(){
//        请求推荐数据
        recommendModel.requestData {
            self.collectionView.reloadData()
            var groups = self.recommendModel.anchorGroups
            // 移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
        }
        
//        请求轮播数据
        recommendModel.requestCycleData {
            self.cycleView.cycleModels = self.recommendModel.cycleModels
        }
    }
}

//MARK: - 遵守UICollectionView的数据协议
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendModel.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出模型对象
        let group = recommendModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //2. 定义cell
        var cell: CollectionBaseCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellID, for: indexPath) as! CollectionPrettyCell
        }
        else
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        headerView.group = recommendModel.anchorGroups[indexPath.section]
        
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: KItemW, height: KPrettyItemH)
        }
        return CGSize(width: KItemW, height: KNormalItemH)
    }
}

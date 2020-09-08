//
//  RecommendControllerViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/5.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let KCycleViewH = KScreenH * 2 / 8
private let KGameViewH:CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    
    //MARK: 懒加载
    fileprivate lazy var recommendModel:RecommendViewModel = RecommendViewModel()

    fileprivate lazy var cycleView:RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y:-(KCycleViewH + KGameViewH), width: KScreenW, height: KCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView:RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y:-KGameViewH , width: KScreenW, height: KGameViewH)
        return gameView
    }()
}

//MARK: 设置UI界面内容
extension RecommendViewController
{
    override func setupUI(){
        
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        //设置内边距
        collectionView.contentInset = UIEdgeInsets(top: KCycleViewH + KGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension RecommendViewController
{
    override func loadData(){
        //0 给父类中vm赋值
        baseVM = recommendModel
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

extension RecommendViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: KNormalItemW, height: KPrettyItemH)
        }
        return CGSize(width: KNormalItemW, height: KNormalItemH)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = recommendModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }
        else
        {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
}

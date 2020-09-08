//
//  GameViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/7.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (KScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50

private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: UIViewController {
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: KScreenW, height: kHeaderViewH)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        
        return collectionView
        }()
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: KScreenW, height: kHeaderViewH)
        headerView.iconView.image = UIImage(named: "Img_orange")
        headerView.titleView.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: KScreenW, height: kGameViewH)
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
    }
}

// MARK:- 设置UI界面
extension GameViewController {
    func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
            
            // 2.展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}

// MARK:- 遵守UICollectionView的数据源&代理
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = gameVM.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置属性
        headerView.titleView.text = "全部"
        headerView.iconView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}

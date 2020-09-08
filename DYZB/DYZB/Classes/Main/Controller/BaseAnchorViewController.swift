//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/8.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let KItemMargin:CGFloat = 10
let KNormalItemW = (KScreenW - 3 * KItemMargin) / 2
let KNormalItemH = KNormalItemW * 3 / 4
let KPrettyItemH = KNormalItemW * 4 / 3
private let KHeaderViewH:CGFloat = 50
private let KCycleViewH = KScreenH * 2 / 8
private let KGameViewH:CGFloat = 90

private let KNormalCellID = "KNormalCellID"
let KPrettyCellID = "KPrettyCellID"
private let KHeaderViewID = "KHeaderViewID"

class BaseAnchorViewController: BaseViewController {
    
    //MARK: - 定义属性
    var baseVM:BaseViewModel!
    
    //MARK: - 懒加载属性
    lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KNormalItemW, height: KNormalItemH)
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
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
    }
}

//MARK: - 设置UI界面
extension BaseAnchorViewController
{
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
    }
}

//MARK: - 发送网络请求
extension BaseAnchorViewController
{
    @objc func loadData()
    {}
}

//MARK: - 遵循UICollectionView的数据源和协议
extension BaseAnchorViewController:UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
         as! CollectionNormalCell
        
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! CollectionHeaderView
        cell.group = baseVM.anchorGroups[indexPath.section]
        return cell
    }
}

//MARK: - 实现UICollectionView的代理协议
extension BaseAnchorViewController:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        anchor.isVertical == 0 ?pushNormalRoomVc(anchor: anchor):presentShowRoomVc(anchor: anchor)
    }
    
    private func presentShowRoomVc(anchor:AnchorModel?){
        let showRoomVc = RoomShowViewController()
        showRoomVc.modalPresentationStyle = .fullScreen
        showRoomVc.anchor = anchor
        present(showRoomVc,animated:true,completion:nil)
    }
    
    private func pushNormalRoomVc(anchor:AnchorModel?){
        let normalRoomVc = RoomNormalViewController()
        normalRoomVc.anchor = anchor
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}

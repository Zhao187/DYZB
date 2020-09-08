//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/7.
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

class AmuseViewController: UIViewController {

    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var collectionView:UICollectionView = { [unowned self] in
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
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }
}

//MARK: - 设置UI界面
extension AmuseViewController
{
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

//MARK: - 发送网络请求
extension AmuseViewController
{
    fileprivate func loadData()
    {
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - 遵循UICollectionView的数据源和协议
extension AmuseViewController:UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
         as! CollectionNormalCell
        
        cell.anchor = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! CollectionHeaderView
        cell.group = amuseVM.anchorGroups[indexPath.section]
        return cell
    }
}

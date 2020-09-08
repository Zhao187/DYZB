//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/8.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let KMenuCellID = "KMenuCellID"

class AmuseMenuView: UIView {
    
    //MARK: - 定义属性
    var groups:[AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIView.AutoresizingMask()
        
        collectionView.register(UINib.init(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: KMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }

}

extension AmuseMenuView
{
    class func amuseMenuView()->AmuseMenuView
    {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMenuCellID, for: indexPath)
         as! AmuseMenuViewCell
        
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell:AmuseMenuViewCell,indexPath:IndexPath)
    {
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

extension AmuseMenuView:UICollectionViewDelegate
{
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / self.collectionView.bounds.width)
    }
}

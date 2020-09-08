//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/8.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let KGameCellID = "KGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    
    //MARK: - 数据模型
    var groups:[AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - 从xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
    
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}

extension AmuseMenuViewCell:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.clipsToBounds = true
        cell.baseGame = groups![indexPath.item]
        
        return cell
    }
}

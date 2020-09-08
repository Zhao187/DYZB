//
//  PageContentView.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/4.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

protocol PageContentViewDelegate:class {
    func pageContentView(contentView:PageContentView,progress:CGFloat
        ,sourceIndex:Int,targetIndex:Int)
}

class PageContentView: UIView {
    
    private var childVcs: [UIViewController]
    private weak var parentViewController:UIViewController?
    private var startOffsetX:CGFloat = 0
    private var isForbidScrollDelegate:Bool = false
    weak var delegate:PageContentViewDelegate?
    
    private lazy var collectionView:UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        collectionView.delegate = self
        return collectionView
    }()
    
    //自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented")
    }
    
}

// MARK: - 设置UI界面
extension PageContentView
{
    private func setupUI(){
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        
        //2.添加UICollectionView,用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame  = bounds
    }
}

//MARK: - 遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        //cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//MARK: - 遵守UICollectionViewDelegate
extension PageContentView:UICollectionViewDelegate
{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         isForbidScrollDelegate = false
               
        startOffsetX =  scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {return}
        
        //1.获取需要数据
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        
        //2.判断是左边滑动还是右边滑动
        let currentOffsetX = scrollView.contentOffset.x
        
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {
//            左边滑动
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            
//            计算sourceIndex
            sourceIndex = Int(currentOffsetX/scrollViewW)
            
//            计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        else
        {
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            
//            计算targetIndex
            targetIndex = Int(currentOffsetX/scrollViewW)
            
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count
            {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK: - 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex:Int) {
        //1.记录需要禁止执行的代理方法
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

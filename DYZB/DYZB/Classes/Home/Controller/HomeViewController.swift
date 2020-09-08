//
//  HomeViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/4.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

private let KTitleViewH:CGFloat = 40

class HomeViewController: UIViewController {

    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleFrame = CGRect(x: 0, y: KStatusBarH+KNavigationBarH, width: KScreenW, height: KTitleViewH)
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView:PageContentView = { [weak self] in
        //确定内容frame
        let contentH = KScreenH - KStatusBarH - KNavigationBarH - KTitleViewH - KTabBarH
        let contentFrame = CGRect(x: 0, y: KStatusBarH+KNavigationBarH+KTitleViewH, width: KScreenW, height: contentH)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

//MARK: - 设置UI界面
extension HomeViewController{
    
    private func setupUI(){
        
        //不需要调整UIScrollView内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar(){
        
        //1.设置左侧
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.设置右侧
        let size = CGSize(width: 35, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click",
                                                     size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size)
        
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]
    }
}

//MARK: -遵循PageTitleViewDelegate协议
extension HomeViewController:PageTitleViewDelegate
{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK: - 遵守PageContentViewDelegate
extension HomeViewController:PageContentViewDelegate
{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

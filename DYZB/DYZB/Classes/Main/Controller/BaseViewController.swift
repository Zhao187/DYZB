//
//  BaseViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/8.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - 定义属性
    var contentView: UIView?
    
    
    //MARK: - 懒加载属性
    fileprivate lazy var animImageView:UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,
                                     UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

//MARK: - 设置界面
extension BaseViewController
{
    @objc  func setupUI() {
        contentView?.isHidden = true
        
        view.addSubview(self.animImageView)
        
        animImageView.startAnimating()
        
        //4.设置背景颜色
        view.backgroundColor = UIColor.init(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished()  {
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
}

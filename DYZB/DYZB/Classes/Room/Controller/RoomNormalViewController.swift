//
//  RoomNormalViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/8.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var maskImageView : UIImageView?
    var anchor: AnchorModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //依然保持手势
         navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension RoomNormalViewController
{
    fileprivate func setupUI()
    {
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: KScreenW, height: 240)
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = imageView.bounds
        imageView.addSubview(effectView)
        
        guard let icon_URL = URL(string: (anchor?.vertical_src)!) else { return }
        imageView.kf.setImage(with: icon_URL)
        maskImageView = imageView
        view.addSubview(maskImageView!)
    }
}

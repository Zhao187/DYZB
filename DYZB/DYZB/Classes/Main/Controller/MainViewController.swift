//
//  MainViewController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/4.
//  Copyright © 2020 赵宏图. All rights reserved.
// storyborad refrece ios9才可以使用 

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")
    }

    private func addChildVc(storyName:String)
    {
        // 1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        
        //2.将childVc作为子控制器
        addChild(childVc)
    }
}

//
//  AppDelegate.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/3.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = nil
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }
}


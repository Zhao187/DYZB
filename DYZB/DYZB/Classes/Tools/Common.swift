//
//  Common.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/4.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

let KStatusBarH:CGFloat = 20
let KNavigationBarH:CGFloat = nabigationBarH()

let KScreenW:CGFloat = UIScreen.main.bounds.width
let KScreenH:CGFloat = UIScreen.main.bounds.height
let KTabBarH:CGFloat = 44


func isiPhoneX() ->Bool {
    let screenHeight = UIScreen.main.nativeBounds.size.height;
    if screenHeight == 2436 || screenHeight == 1792 || screenHeight == 2688 || screenHeight == 1624 {
        return true
    }
    return false
}

private func nabigationBarH()->CGFloat
{
    if isiPhoneX() {
        return 64
    }
    return 44
}


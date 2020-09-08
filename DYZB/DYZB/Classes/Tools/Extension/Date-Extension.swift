//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/6.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime()->String{
        let nowDate = NSDate()
        let interval=Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}

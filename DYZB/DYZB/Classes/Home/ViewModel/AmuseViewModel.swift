//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/7.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
}

extension AmuseViewModel
{
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(URLString:  "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}

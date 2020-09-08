//
//  FunnyViewModel.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/8.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

class FunnyViewModel:BaseViewModel {

}

extension FunnyViewModel
{
    func loadFunnyData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/1", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}

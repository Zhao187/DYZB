//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/7.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

class AmuseViewModel: NSObject {
  lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel
{
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            finishedCallback()
        }
    }
}

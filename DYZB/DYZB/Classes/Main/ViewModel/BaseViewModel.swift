//
//  BaseViewModel.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/8.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

class BaseViewModel {
  lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
}


extension BaseViewModel
{
    func loadAnchorData(URLString:String,parameters:[String:Any]? = nil,finishedCallback:@escaping ()->())  {
        NetworkTools.requestData(.get, URLString: URLString,parameters: parameters) { (result) in
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

//
//  RecomendViewModel.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/6.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit
class RecommendViewModel:BaseViewModel
{
    //    MARK: - 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// MARK: - 发送网络数据
extension RecommendViewModel
{
    //请求推荐数据
    func requestData(_ finishCallback:@escaping()->()) {
        //定义参数
        let parameters:[String:Any] = ["limit":4,"offset":0,"time":Date.getCurrentTime()]
        //创建组
        let dGroup = DispatchGroup()
        
        //请求推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            guard let restDict = result as? [String:NSObject] else {return}
            
            guard let dataArray = restDict["data"] as? [[String:NSObject]] else {return}
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.small_icon_url = "home_header_hot"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        //颜值请求
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let restDict = result as? [String:NSObject] else {return}
            
            guard let dataArray = restDict["data"] as? [[String:NSObject]] else {return}
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.small_icon_url = "home_header_phone"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        // 5.请求2-12部分游戏数据
        dGroup.enter()
        
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
        }
        
        // 6.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    
    //请求轮播数据
    func requestCycleData(_ finishCallback:@escaping()->()) {
//        http://www.douyutv.com/api/v1/slide/6?version=2.300
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            guard let resultDict = result as? [String:NSObject] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }

            finishCallback()
        }
    }
}

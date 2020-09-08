//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/4.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
    /*
    class func createItem(imageName:String,highImageName:String,size:CGSize)->UIBarButtonItem{
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn )
    }*/
    
    //便利构造函数  1.convenience 开头 2.构造函数中必须调用一个设计的构造函数(self)
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
             btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
         
        if size == CGSize.zero {
            btn.sizeToFit()
        }
        else
        {
          btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn )
    }
}

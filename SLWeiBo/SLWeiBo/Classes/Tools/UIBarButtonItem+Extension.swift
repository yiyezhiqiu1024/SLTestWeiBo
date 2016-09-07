//
//  UIBarButtonItem+Extension.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/7.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
    convenience init(imageName: String, target: AnyObject?, action: Selector) {
        
        /// 1.用于快速创建一个对象
        /// 2.依赖于指定构造方法
        let btn: UIButton = UIButton()
        btn.setImage(UIImage.init(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage.init(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        
        self.init(customView: btn)
       }
}

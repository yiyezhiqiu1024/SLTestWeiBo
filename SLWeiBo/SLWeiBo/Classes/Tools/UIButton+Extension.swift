//
//  UIButton+Extension.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/3.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

extension UIButton
{
    /**
     自定义按钮并设置相关属性
     
     - parameter imageName:        前景图片名
     - parameter backgroundImage:  背景图片名
     - parameter target:           监听者
     - parameter action:           监听行为
     - parameter forControlEvents: 监听事件类型
     
     - returns: <#return value description#>
     */
    convenience init(imageName: String, backgroundImage: String, target: AnyObject?, action: Selector, forControlEvents: UIControlEvents)
    {
        self.init()
        
        // 前景图片
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        
        // 背景图片
        setBackgroundImage(UIImage(named: backgroundImage), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backgroundImage + "_highlighted"), forState: UIControlState.Highlighted)
        
        // 调整尺寸
        sizeToFit()
        
        // 监听点击事件
        addTarget(target, action: action, forControlEvents: forControlEvents)

    }
}



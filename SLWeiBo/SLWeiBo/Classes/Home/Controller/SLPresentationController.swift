//
//  SLPresentationController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/10.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class SLPresentationController: UIPresentationController {

    var presentFrame = CGRectZero
    /*
     1.如果不自定义转场modal出来的控制器会移除原有的控制器
     2.如果自定义转场modal出来的控制器不会移除原有的控制器
     3.如果不自定义转场modal出来的控制器的尺寸和屏幕一样
     4.如果自定义转场modal出来的控制器的尺寸我们可以自己在containerViewWillLayoutSubviews方法中控制
     5.containerView 非常重要, 容器视图, 所有modal出来的视图都是添加到containerView上的
     6.presentedView() 非常重要, 通过该方法能够拿到弹出的视图
     */
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController)
    {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    // 用于布局转场动画弹出的控件
    override func containerViewWillLayoutSubviews()
    {
        // 1.设置控制器尺寸
        presentedView()?.frame = presentFrame
        
        // 2.添加蒙版到容器视图
        containerView?.insertSubview(coverButton, atIndex: 0)
        coverButton.addTarget(self, action: #selector(SLPresentationController.coverButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    //==========================================================================================================
    // MARK: - 处理监听事件
    //==========================================================================================================
    /**
     监听蒙版按钮点击
     */
    @objc private func coverButtonClick()
    {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //==========================================================================================================
    // MARK: - 懒加载
    //==========================================================================================================
    /// 蒙版按钮
    private lazy var coverButton: UIButton = {
        
       () -> (UIButton)
        in
        
        let btn: UIButton = UIButton()
        btn.frame = UIScreen.mainScreen().bounds
        btn.backgroundColor = UIColor.clearColor()
        return btn
    }()
}

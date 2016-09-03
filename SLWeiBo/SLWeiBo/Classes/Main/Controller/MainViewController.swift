//
//  MainViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/3.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置按钮尺寸
        // 先保存按钮尺寸
        let cmpBtnRect: CGRect  = composeButton.frame
        
        // 获取TabBarButton的宽度
        let tabBarBtnWidth: CGFloat = tabBar.bounds.width / CGFloat(childViewControllers.count)
       
        composeButton.frame = CGRect(x: tabBarBtnWidth * 2, y: 0, width: tabBarBtnWidth, height: cmpBtnRect.height)
        
        // 添加加号按钮
        tabBar.addSubview(composeButton)
       
    }

    //==========================================================================================================
    // MARK: - 监听函数
    //==========================================================================================================
    
    /**
     监听加号按钮点击
     */
    @objc private func composeButtonClick(button: UIButton) -> Void {
        myLog("➕按钮被点击了")
    }
    
    //==========================================================================================================
    // MARK: - 懒加载
    //==========================================================================================================
    /// 加号按钮
    private lazy var composeButton: UIButton = {
        () -> (UIButton)
        in
        
        let btn = UIButton()
        
        // 前景图片
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        // 背景图片
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        // 调整尺寸
        btn.sizeToFit()
        
        // 监听点击事件
        btn.addTarget(self, action: #selector(MainViewController.composeButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()

}

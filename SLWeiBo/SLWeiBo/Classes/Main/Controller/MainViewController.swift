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
        
        return UIButton(imageName: "tabbar_compose_icon_add", backgroundImage: "tabbar_compose_button", target: self, action: #selector(MainViewController.composeButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    
    }()

}

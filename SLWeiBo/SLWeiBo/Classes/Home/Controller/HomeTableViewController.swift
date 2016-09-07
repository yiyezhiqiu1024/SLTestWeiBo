//
//  HomeTableViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/3.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.判断用户是否登录
        if !isLogin
        {
            visitorView?.setupVisitorViewInfo(nil, text: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 2.已登录，设置导航条
        setupNav()
        
    }
    
    //==========================================================================================================
    // MARK: - 内部控制函数
    //==========================================================================================================

    /**
     设置导航条左右的按钮
     */
    private func setupNav() -> Void {
        
       /*
         // 方式一
        let leftButton: UIButton = UIButton()
        leftButton.setImage(UIImage.init(named: "navigationbar_friendattention"), forState: UIControlState.Normal)
        leftButton.setImage(UIImage.init(named: "navigationbar_friendattention_highlighted"), forState: UIControlState.Highlighted)
        leftButton.addTarget(self, action: #selector(HomeTableViewController.leftButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
         leftButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
         
         let rightButton: UIButton = UIButton()
         rightButton.setImage(UIImage.init(named: "navigationbar_pop"), forState: UIControlState.Normal)
         rightButton.setImage(UIImage.init(named: "navigationbar_pop_highlighted"), forState: UIControlState.Highlighted)
         rightButton.addTarget(self, action: #selector(HomeTableViewController.rightButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
         rightButton.sizeToFit()
         navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton)
         */
        
        /*
         // 方式二
        navigationItem.leftBarButtonItem = createBarButtonItem("navigationbar_friendattention")
        navigationItem.rightBarButtonItem = createBarButtonItem("navigationbar_pop")
         */
        
        // 方式三
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_friendattention", target: self, action: #selector(HomeTableViewController.leftButtonClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightButtonClick))
    }
    
    /*
    /**
     快速创建一个导航条按钮
     
     - parameter imageName: 按钮的图片
     
     - returns: UIBarButtonItem
     */
    private func createBarButtonItem(imageName: String) ->UIBarButtonItem
    {
        let btn: UIButton = UIButton()
        btn.setImage(UIImage.init(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage.init(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)

    }
     */
    
    /**
     监听导航条左边按钮点击
     */
    @objc private func leftButtonClick() -> Void
    {
        myLog("")
    }
    
    /**
     监听导航条右边按钮点击
     */
    @objc private func rightButtonClick() -> Void
    {
        myLog("")
    }

}

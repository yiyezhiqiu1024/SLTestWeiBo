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
     设置导航条
     */
    private func setupNav() -> Void {
        // 1.导航条左边按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_friendattention", target: self, action: #selector(HomeTableViewController.leftButtonClick))
        // 2.导航条右边按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightButtonClick))
        
        // 3.导航条中间标题按钮
        let titleButton: UIButton = TitleButton()
        titleButton.setTitle("夜幕下的超人", forState: UIControlState.Normal)
        titleButton.addTarget(self, action: #selector(HomeTableViewController.titleButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = titleButton
        }
    
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
    
    @objc private func titleButtonClick(button: UIButton) -> Void
    {
        button.selected = !button.selected
        myLog("")
    }

}

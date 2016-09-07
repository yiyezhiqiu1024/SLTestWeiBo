//
//  BaseTableViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/3.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    // 记录用户登录的标识
    let isLogin: Bool = true
    
    // 访客窗口
    var visitorView: VisitorView?
    
    /**
     重写loadView方法
     */
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    //==========================================================================================================
    // MARK: - 内部控制方法
    //==========================================================================================================

    /**
     设置访客窗口
     */
    private func setupVisitorView() -> Void {
        visitorView = VisitorView.visitorView()
        view = visitorView
        
        visitorView?.registerButton.addTarget(self, action: #selector(BaseTableViewController.registerButtonDidClick), forControlEvents: UIControlEvents.TouchUpInside)
        visitorView?.loginButton.addTarget(self, action: #selector(BaseTableViewController.loginButtonDidClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.registerButtonDidClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.loginButtonDidClick))
        
    }
    
    
    //==========================================================================================================
    // MARK: 监听事件处理
    //==========================================================================================================
    
    /**
     监听注册按钮点击
     */
    @objc private func registerButtonDidClick() -> Void
    {
        myLog("注册按钮被点击")
    }
    
    /**
     监听登录按钮点击
     */
    @objc private func loginButtonDidClick() -> Void
    {
        myLog("登录按钮被点击")
    }

}

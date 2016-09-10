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
        
        // 3.添加通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.titleImageChange), name: PresentationManagerDidPresented, object: animationManager)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.titleImageChange), name: PresentationManagerDidDismissed, object: animationManager)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
        let sb: UIStoryboard  = UIStoryboard(name: "QRCode", bundle: nil)
        guard let qrcVC: UIViewController = sb.instantiateInitialViewController() else
        {
            return
        }
        
        presentViewController(qrcVC, animated: true, completion: nil)
    }
    
    /**
     监听导航条标题按钮点击
    */
    @objc private func titleButtonClick(button: UIButton) -> Void
    {
        
        /// 1.加载UIStoryboard
        let sb: UIStoryboard = UIStoryboard.init(name: "Popover", bundle: nil)
        /// 2.初始化菜单控制器
        guard let menuVC: UIViewController = sb.instantiateInitialViewController() else
        {
            myLog("")
            return
        }
        
        // 3.设置转场代理
        menuVC.transitioningDelegate = animationManager
        
        // 4.设置转场动画样式
        menuVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        // 5.显示菜单控制器
        presentViewController(menuVC, animated: true, completion: nil)

    }
    
    /**
     标题图片发生改变
     */
    @objc private func titleImageChange() -> Void
    {
        titleButton.selected = !titleButton.selected
    }
    
    //==========================================================================================================
    // MARK: - 懒加载
    //==========================================================================================================
    private lazy var animationManager: PresentationManager = {
       
        () -> (PresentationManager)
        in
        
        let mgr = PresentationManager()
        mgr.presentFrame = CGRect(x: 100, y: 64, width: 200, height: 300)
        return mgr
    }()
    
    private lazy var titleButton: TitleButton = {
        () -> (TitleButton)
        in
        
        let btn  = TitleButton()
        btn.setTitle("夜幕下的超人", forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(HomeTableViewController.titleButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return btn;
    }()

}


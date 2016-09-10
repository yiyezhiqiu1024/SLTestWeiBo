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
    
    /**
     监听导航条标题按钮点击
    */
    @objc private func titleButtonClick(button: UIButton) -> Void
    {
        button.selected = !button.selected
        
        /// 1.加载UIStoryboard
        let sb: UIStoryboard = UIStoryboard.init(name: "Popover", bundle: nil)
        /// 2.初始化菜单控制器
        guard let menuVC: UIViewController = sb.instantiateInitialViewController() else
        {
            myLog("")
            return
        }
        
        // 3.设置转场代理
        menuVC.transitioningDelegate = self
        
        // 4.设置转场动画样式
        menuVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        // 5.显示菜单控制器
        presentViewController(menuVC, animated: true, completion: nil)

    }

    // 定义是否显示菜单控制器的标记
    private var isPresent: Bool = false
}

// MARK: - UIViewControllerTransitioningDelegate
extension HomeTableViewController: UIViewControllerTransitioningDelegate
{
    
    
    // 返回一个负责转场动画的对象
     func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return SLPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    // 返回一个负责转场动画如何展现的对象
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        return self
    }
    
    // 返回一个负责转场动画如何消失的对象
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        return self
    }
    
}

extension HomeTableViewController: UIViewControllerAnimatedTransitioning
{
    // 告诉系统展现和消失的动画时长
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.5
    }
    
    // 专门用于管理moda如何展现和消失的，无论是展现还是消失都会调用该函数
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        // 判断当前是展现还是消失
        if isPresent
        { // 展现
            // 1.通过ToViewKey取出的toVC对应的view
            guard let toView = transitionContext.viewForKey(UITransitionContextToViewKey) else
            {
                return
            }
            
            transitionContext.containerView()?.addSubview(toView)
            // 2.设置变化比例
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            // 3.设置锚点
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            // 4.执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
                toView.transform = CGAffineTransformIdentity
                }, completion: { (_) in
                    // 注意：自定义转场动画，在执行完动画之后一定要告诉系统动画执行完毕了
                    transitionContext.completeTransition(true)
            })
            
        } else
        { // 消失
            guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else
            {
                return
            }
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
                fromView.transform = CGAffineTransformMakeScale(1.0, 0.000001)
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
            })
        }
    }
}

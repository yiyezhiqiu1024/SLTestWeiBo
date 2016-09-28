//
//  PresentManager.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/10.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class PresentationManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    // 定义是否显示菜单控制器的标记
    private var isPresent: Bool = false
    
    var presentFrame = CGRectZero
    
    // 返回一个负责转场动画的对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        let pc: SLPresentationController  = SLPresentationController(presentedViewController: presented, presentingViewController: presenting)
        pc.presentFrame = presentFrame
        return pc
    }
    
    // 返回一个负责转场动画如何展现的对象
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        NSNotificationCenter.defaultCenter().postNotificationName(PresentationManagerDidPresented, object: self)
        return self
    }
    
    // 返回一个负责转场动画如何消除的对象
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        NSNotificationCenter.defaultCenter().postNotificationName(PresentationManagerDidDismissed, object: self)
        return self
    }
    
    // 告诉系统展现和消除的动画时长
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.5
    }
    
    // 专门用于管理moda如何展现和消失的，无论是展现还是消除都会调用该函数
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        // 判断当前是展现还是消失
        if isPresent
        { // 展现
            willPresentedController(transitionContext)
        } else
        { // 消除
            willDismissController(transitionContext)
        }
    }
    
    /**
     即将展现
     
     - parameter transitionContext: 转场上下文
     */
    private func willPresentedController(transitionContext: UIViewControllerContextTransitioning)
    {
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
    }
    
    /**
     即将消除
     
     - parameter transitionContext: 转场上下文
     */
    private func willDismissController(transitionContext: UIViewControllerContextTransitioning)
    {
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

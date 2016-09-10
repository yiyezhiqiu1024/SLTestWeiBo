//
//  QRCodeViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/10.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

    /// 底部工具条
    @IBOutlet weak var customTabBar: UITabBar!
    /// 冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    /// 冲击波视图顶部约束
    @IBOutlet weak var scanLineTopCons: NSLayoutConstraint!
    /// 容器视图高度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    
    //==========================================================================================================
    // MARK: - 系统控制
    //==========================================================================================================

    override func viewDidLoad() {
        super.viewDidLoad()

        // 工具条默认选中第一个item
        customTabBar.selectedItem = customTabBar.items?.first
        
        customTabBar.delegate = self
        
        startAnmation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // 开始动画
//        startAnmation()
    }
    
    //==========================================================================================================
    // MARK: - 内部控制函数
    //==========================================================================================================
    /**
     开始动画
     */
    private func startAnmation() -> Void
    {
        // 设置尺寸
        scanLineTopCons.constant =  -containerHeightCons.constant
        view.layoutIfNeeded()
        
        /**
         *  执行动画
         */
        UIView.animateWithDuration(1.0) {
            () -> (Void)
            in
            
            // 设置动画循环次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineTopCons.constant = self.containerHeightCons.constant
            self.view.layoutIfNeeded()
        }
    }

    //==========================================================================================================
    // MARK: - 监听事件处理
    //==========================================================================================================
    /**
     监听导航条左边关闭按钮
     */
    @IBAction func closeClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     监听导航条右边相册按钮
     */
    @IBAction func photoClick(sender: AnyObject) {
        myLog("")
    }
}

// MARK: - UITabBarDelegate
extension QRCodeViewController: UITabBarDelegate
{
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        containerHeightCons.constant = (item.tag == 1) ? 100 : 200
        view.layoutIfNeeded()
        
        /**
         *  移除所有的动画
         */
        scanLineView.layer.removeAllAnimations()
        
        /**
         *  开始动画
         */
        startAnmation()
    }
}


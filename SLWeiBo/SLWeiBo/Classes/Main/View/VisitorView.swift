//
//  VisitorView.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/3.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

/**
 * 声明访客视图的代理函数
 */
protocol VisitorViewDelegate: NSObjectProtocol {
    func visitorViewDidClickRegisterButton(visitorView: VisitorView)
    func visitorViewDidClickLoginButton(visitorView: VisitorView)
}

class VisitorView: UIView {

    /* 装盘 */
    @IBOutlet weak var rotationImageView: UIImageView!
    /* 图标 */
    @IBOutlet weak var iconImageView: UIImageView!
    /* 文本 */
    @IBOutlet weak var textLabel: UILabel!
    /* 注册按钮 */
    @IBOutlet weak var registerButton: UIButton!
    /* 登录按钮 */
    @IBOutlet weak var loginButton: UIButton!
    /* 代理 */
    weak var delegate: VisitorViewDelegate?
    
    //==========================================================================================================
    // MARK: - 内部控制函数
    //==========================================================================================================

    /**
     加载Xib
     
     - returns: Xib视图
     */
    class func visitorView() -> VisitorView {
        return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).last as! VisitorView
    }
    
    /**
     设置访客视图的数据
     
     - parameter imageName: 图标名称
     - parameter text:      文本内容
     */
    func setupVisitorViewInfo(imageName: String?, text: String) -> Void
    {
        // 1.设置标题
        textLabel.text = text
        
        // 2.判断是否是首页
        guard let name = imageName else
        {
            // 没有设置图标名称，就是首页，执行转盘动画
            startAnimation()
            return
        }
        
        // 3.不是首页，设置其他数据
        rotationImageView.hidden = true
        
        // 4.设置图标
        if "" == name
        {
            myLog("")
            return
        }
        
        iconImageView.image = UIImage(named: name)
    }
    
    /**
     开始动画
     */
    private func startAnimation() -> Void
    {
        // 1.创建动画
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        // 2.设置动画属性
        animation.toValue = 2 * M_PI
        animation.duration = 5.0
        animation.repeatCount = MAXFLOAT
        
        // 3.视图消失时，不移除动画
        animation.removedOnCompletion = false
        
        // 4.将动画添加到图层上
        rotationImageView.layer.addAnimation(animation, forKey: nil)
    }
    
    //==========================================================================================================
    // MARK: 监听事件处理
    //==========================================================================================================

    /**
     监听注册按钮点击
     */
    @IBAction func registerButtonClick(sender: AnyObject) {
        delegate?.visitorViewDidClickRegisterButton(self)
    }
    
    /**
     监听登录按钮点击
     */
    @IBAction func loginButtonClick(sender: AnyObject) {
        delegate?.visitorViewDidClickLoginButton(self)
    }

}

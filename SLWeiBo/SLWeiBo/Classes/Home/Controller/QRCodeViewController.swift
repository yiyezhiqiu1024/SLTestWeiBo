//
//  QRCodeViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/10.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

    //==========================================================================================================
    // MARK: - 成员属性
    //==========================================================================================================

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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // UI完全显示的时候，再开始动画
        startAnmation()
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
        UIView.animateWithDuration(2.0) {
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
        let pc: UIImagePickerController = UIImagePickerController()
        pc.delegate = self
        presentViewController(pc, animated: true, completion: nil)
    }
}

//==========================================================================================================
// MARK: - UITabBarDelegate
//==========================================================================================================
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

//==========================================================================================================
// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
//==========================================================================================================
extension QRCodeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        // 1.取出选中的图片
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else
        {
            return
        }
        
        guard let ciImage = CIImage(image: image) else
        {
            return
        }
        
        // 2.从选中的图片中读取二维码数据
        // 2.1创建一个探测器
        let detector: CIDetector =  CIDetector(ofType: CIDetectorTypeText, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        // 2.2利用探测器探测数据
        let results: [CIFeature] = detector.featuresInImage(ciImage)
        // 2.3取出探测到的数据
        for result in results {
            myLog((result as! CIQRCodeFeature).messageString)
        }
        
        // 选中了任意一张图片，就会调用这个函数，移除imagePickerController
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

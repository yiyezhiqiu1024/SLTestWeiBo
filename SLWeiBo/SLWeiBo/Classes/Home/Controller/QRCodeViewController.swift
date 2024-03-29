//
//  QRCodeViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/10.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {
    
    //==========================================================================================================
    // MARK: - 成员属性
    //==========================================================================================================
    /// 扫描容器视图
    @IBOutlet weak var containerView: UIView!
    /// 底部工具条
    @IBOutlet weak var customTabBar: UITabBar!
    /// 冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    /// 冲击波视图顶部约束
    @IBOutlet weak var scanLineTopCons: NSLayoutConstraint!
    /// 容器视图高度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    /// 二维码信息
    @IBOutlet weak var customLabel: UILabel!
    //==========================================================================================================
    // MARK: - 懒加载
    //==========================================================================================================
    /// 输入对象
    private lazy var input: AVCaptureDeviceInput? = {
        () -> AVCaptureDeviceInput?
        in
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        return try? AVCaptureDeviceInput(device: device)
    }()
    
    /// 输出对象
    private lazy var output: AVCaptureMetadataOutput = {
        () -> AVCaptureMetadataOutput
        in
        
        let out = AVCaptureMetadataOutput()
        // 屏幕尺寸
        let viewRect = self.view.frame
        // 扫描容器尺寸
        let containerRect = self.containerView.frame
        
        let x: CGFloat = containerRect.origin.y / viewRect.size.height
        let y: CGFloat = containerRect.origin.x / viewRect.size.width
        let width: CGFloat = containerRect.size.height / viewRect.size.height
        let heigth: CGFloat = containerRect.size.width / viewRect.size.width

        // 指定输出对象矩形指定兴趣范围
        out.rectOfInterest = CGRect(x: x, y: y, width: width, height: heigth)
        
        return out
    }()
    
    /// 会话
    private lazy var session: AVCaptureSession = AVCaptureSession()
    
    /// 预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    /// 专门用于描边的图层
    private lazy var containerLayer: CALayer = CALayer()
    //==========================================================================================================
    // MARK: - 系统控制
    //==========================================================================================================

    override func viewDidLoad() {
        super.viewDidLoad()

        // 工具条默认选中第一个item
        customTabBar.selectedItem = customTabBar.items?.first
        // 设置底部工具条代理
        customTabBar.delegate = self
        
        // 扫描二维码
        scanQRCode()
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
    
    /**
     扫描二维码
     */
    private func scanQRCode() -> Void {
        // 1.判断输入对象是否可以添加到会话
        if !session.canAddInput(input)
        {
            return
        }
        // 2.判断输出对象是否可以添加到会话
        if !session.canAddOutput(output)
        {
            return
        }
        // 3.添加输入、输出对象到会话
        session.addInput(input)
        session.addOutput(output)
        
        // 4.设置输出对象能够解析元数据类型
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        // 5.监听输出解析到的数据
        
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        // 6.添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        previewLayer.frame = view.bounds
        
        // 7.会话开始运行
        session.startRunning()
        
    }
    
    /**
     对扫描的二维码进行描边
     
     - parameter objc: 二维码数据
     */
    private func drawLines(objc: AVMetadataMachineReadableCodeObject) -> Void
    {
        // 1.安全校验
        guard let array = objc.corners else
        {
            return
        }
        
        // 2.创建图层，用于保存绘制的矩形
        let layer: CAShapeLayer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.greenColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        
        // 3.创建UIBezierPath，绘制矩形
        let path = UIBezierPath()
        var point = CGPointZero
        var index = 0
        CGPointMakeWithDictionaryRepresentation((array[index++] as! CFDictionary), &point)
        
        // 2.1将起点移动到某一个点
        path.moveToPoint(point)
        
        // 2.2连接线段
        if index < array.count {
            CGPointMakeWithDictionaryRepresentation((array[index++] as! CFDictionary), &point)
            path.addLineToPoint(point)
        }
        
        // 3.关闭路径
        path.closePath()
        
        layer.path = path.CGPath
        
        // 4.将用于保存矩形的图层添加到界面上
        containerLayer.addSublayer(layer)
        
    }

    /**
     清空图层
     */
    private func clearLayer() -> Void
    {
        guard let sublayers = containerLayer.sublayers else
        {
            return
        }
        
        for sublayer in sublayers
        {
            sublayer.removeFromSuperlayer()
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


//==========================================================================================================
// MARK: - AVCaptureMetadataOutputObjectsDelegate
//==========================================================================================================
extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate
{
    // 扫描到结果就会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        // 1.显示结果
        customLabel.text = metadataObjects.last?.stringValue
        
        // 2.清空图层
        clearLayer()
        
        // 3.拿到扫描到的数据
        guard let metadata = metadataObjects.last as? AVMetadataObject else
        {
            return
        }
        
        // 4.通过预览图层将corner值转换为我们能够识别的类型
        let objc = previewLayer.transformedMetadataObjectForMetadataObject(metadata)
        
        // 5.对扫描到的二维码进行描边
        drawLines(objc as! AVMetadataMachineReadableCodeObject)
    }
}
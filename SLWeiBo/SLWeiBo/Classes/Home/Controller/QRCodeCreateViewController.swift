//
//  QRCodeCreateViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/10.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class QRCodeCreateViewController: UIViewController {

    /// 二维码容器
    @IBOutlet weak var scanLineContainerView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.创建滤镜
        let filer: CIFilter? = CIFilter(name: "CIQRCodeGenerator")
        
        // 2.还原滤镜默认属性
        filer?.setDefaults()
        
        // 3.设置需要生成二维码的数据到滤镜中
        
        filer?.setValue("夜幕下的超人".dataUsingEncoding(NSUTF8StringEncoding), forKeyPath: "InputMessage")
        
        // 4.从滤镜中取出生成好的二维码图片
        guard let ciImage: CIImage = filer?.outputImage else
        {
            return
        }
        
        scanLineContainerView.image = createNonInterpolatedUIImageFormCIImage(ciImage, size: 1000)
    }

    
    /**
     生成高清二维码
     
     - parameter image: 需要生成原始图片
     - parameter size:  生成的二维码的宽高
     */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent))
        
        // 1.创建bitmap;
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 2.保存bitmap到图片
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)
    }

}

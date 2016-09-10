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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 工具条默认选中第一个item
        customTabBar.selectedItem = customTabBar.items?.first
    }

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

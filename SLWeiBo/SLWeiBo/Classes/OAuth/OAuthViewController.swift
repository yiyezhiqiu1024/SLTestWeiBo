//
//  OAuthViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/28.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    /// 授权网页容器
    @IBOutlet weak var OAuthWebView: UIWebView!
    
    //==========================================================================================================
    // MARK: - 系统内部控制函数
    //==========================================================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.授权网页路径
        let urlStr: String = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_APP_KEY)&redirect_uri=\(WB_APP_REDIRECT)"
        guard let url: NSURL = NSURL(string: urlStr) else
        {
            return
        }
        
        // 2.创建网络请求
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        // 3.加载授权网页
        OAuthWebView.loadRequest(request)
    }
    
    //==========================================================================================================
    // MARK: - 监听事件处理函数
    //==========================================================================================================
    /**
     监听导航条左边关闭按钮的点击
     */
    @IBAction func closeClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

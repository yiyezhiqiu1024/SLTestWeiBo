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
        let urlStr: String = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_APP_KEY)&redirect_uri=\(WB_APP_REDIRECT_URI)"
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

//==========================================================================================================
// MARK: - UIWebViewDelegate
//==========================================================================================================
extension OAuthViewController: UIWebViewDelegate
{
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 登录界面 : https://api.weibo.com/oauth2/authorize?client_id=2550724916&redirect_uri=http://www.baidu.com
        // 输入账户密码之后 https://api.weibo.com/oauth2/authorize
        // 授权 http://www.baidu.com/?code=8f92ca9aac8b815993357d1113a4aaf1
        // 取消授权 http://www.baidu.com/?error_uri=%2Foauth2%2Fauthorize&error=access_denied&error_description=user%20denied%20your%20request.&error_code=21330
        
        // 1.获取Requset的URL并转换成String
        guard let urlStr: String = request.URL?.absoluteString else
        {
            return false
        }
    
        // 2.根据前缀判断是否是授权回调界面
        if !urlStr.hasPrefix(WB_APP_REDIRECT_URI)
        {
            myLog("不是授权回调界面")
            return true
        }

        // 3.根据是否包含key字符串,获取code
        myLog("是授权回调界面")
        let key: String = "code="
        if urlStr.containsString(key)
        {   
            let code: String? = request.URL!.query?.substringFromIndex(key.endIndex)
            loadAccessToken(code)
            
            return false
        }
        
        myLog("授权失败")
        return false
    }
    
    /**
     利用RequestToken获取AccessToken
     */
    func loadAccessToken(codeStr: String?) -> Void {
        // 1.判断是否有值
        guard let code = codeStr else
        {
            return
        }
        // 2.准备请求路径
        let URLString: String = "oauth2/access_token"
        // 3.准备请求参数
        let parameters = ["client_id": WB_APP_KEY, "client_secret": WB_APP_CLIENT_SECRET, "grant_type": "authorization_code", "code": code, "redirect_uri": WB_APP_REDIRECT_URI]
        // 4.发送POST请求
        SessionManager.sharInstance.POST(URLString, parameters: parameters, progress: { (progress: NSProgress) in
            
            }, success: { (task: NSURLSessionDataTask, objc: AnyObject?) in
//                myLog(objc)
                let dict = objc as! [String: AnyObject]
                
                let account = UserAccount(dict: dict)
                account.saveAccount()
                /*
                 "access_token" = "2.00aDTKiF9EacmC6d421cc6840cp7WB";
                 "expires_in" = 157679999;
                 "remind_in" = 157679999;
                 uid = 5233317922;
                 */
            }) { (task, error) in
                myLog(error)
        }
        
    }
}
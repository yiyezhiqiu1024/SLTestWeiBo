//
//  MessageTableViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/3.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class MessageTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin
        {
            visitorView?.setupVisitorViewInfo("visitordiscover_image_message", text: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
        }
    }

}

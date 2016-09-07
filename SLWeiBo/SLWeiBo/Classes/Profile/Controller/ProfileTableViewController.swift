//
//  ProfileTableViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/3.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin
        {
            visitorView?.setupVisitorViewInfo("visitordiscover_image_profile", text: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            return
        }
    }

}

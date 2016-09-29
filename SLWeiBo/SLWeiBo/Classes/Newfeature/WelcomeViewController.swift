//
//  WelcomeViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/29.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit
import SDWebImage


class WelcomeViewController: UIViewController {

    /// 头像
    @IBOutlet weak var iconImageView: UIImageView!
    
    // 描述文字
    @IBOutlet weak var customLabel: UILabel!
    
    // 底部约束
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.设置头像圆角
        iconImageView.layer.cornerRadius = 45
        iconImageView.clipsToBounds = true
        // 2.断言
        assert(UserAccount.loadUserAccount() != nil, "使用该函数需要先授权才能显示欢迎界面")
        
        // 3.设置头像和描述文字
        let account = UserAccount.loadUserAccount()!
        
        guard let url = NSURL(string: account.avatar_large!) else
        {
            return
        }
        iconImageView.sd_setImageWithURL(url)
        customLabel.text = account.screen_name!
    }

    override func viewDidAppear(animated: Bool) {
        
        bottomConstraint.constant = UIScreen.mainScreen().bounds.size.height - bottomConstraint.constant
        
        UIView.animateWithDuration(2.0, animations: { 
            self.view.layoutIfNeeded()
            }) { (_) in
                UIView.animateWithDuration(2.0, animations: { 
                    self.customLabel.alpha = 1.0
                })
        }
    }
    

}

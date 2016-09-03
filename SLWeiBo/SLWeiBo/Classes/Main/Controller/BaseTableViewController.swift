//
//  BaseTableViewController.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/3.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    // 记录用户登录的标识
    let isLogin: Bool = false
    
    // 访客窗口
    var visitorView: VisitorView?
    
    /**
     重写loadView方法
     */
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    //==========================================================================================================
    // MARK: - 内部控制方法
    //==========================================================================================================

    /**
     设置访客窗口
     */
    private func setupVisitorView() -> Void {
        visitorView = VisitorView.visitorView()
        view = visitorView
    }
    
}

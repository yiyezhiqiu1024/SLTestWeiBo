//
//  AppDelegate.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/3.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        myLog("testMyLog👌")
        return true
    }

}


/**
 自定义LOG
 
 - parameter message:  给外界提供的消息参数
 - parameter file:     文件
 - parameter line:     行号
 - parameter function: 函数名
 */
func myLog<T>(message: T, file: String = #file, line: Int = #line, function: String = #function) -> Void
{
    #if DEBUG
        print("\((file as NSString).lastPathComponent):\(line) \(function): \(message)")
    #endif
}
//
//  SessionManager.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/29.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit
import AFNetworking

class SessionManager: AFHTTPSessionManager {

    /// 单例对象
    static let sharInstance: SessionManager = {
        let baseURL = NSURL(string: "https://api.weibo.com/")
        let instance = SessionManager.init(baseURL: baseURL, sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        instance.responseSerializer.acceptableContentTypes = (NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as! Set)
        
        return instance
    }()
}

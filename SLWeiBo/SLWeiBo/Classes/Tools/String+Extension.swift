//
//  String+Extension.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/29.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import Foundation

extension String
{
    func cachesDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        let name = (self as NSString).lastPathComponent
        return path.stringByAppendingPathComponent(name)
        
    }
    
    func documentDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        let name = (self as NSString).lastPathComponent
        return path.stringByAppendingPathComponent(name)
    }
    
    func temporaryDid() -> String
    {
        let path = NSTemporaryDirectory() as NSString
        let name = (self as NSString).lastPathComponent
        return path.stringByAppendingPathComponent(name)
    }
}
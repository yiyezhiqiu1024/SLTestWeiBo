//
//  UserAccount.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/29.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {

    /// 用户授权的唯一票据，
    var access_token: String?
    /// access_token的生命周期，单位是秒数
    var expires_in: Int = 0
        {
            didSet
            {
                expires_date = NSDate(timeIntervalSinceNow: NSTimeInterval(expires_in))
        }
    }
    
    var expires_date: NSDate?
    /// 授权用户的UID
    var uid: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        // KVC
        setValuesForKeysWithDictionary(dict)
    }
    
    // 当KVC发现没有对应的key时就会调用
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String
    {
        return "abc"
    }
    
    //==========================================================================================================
    // MARK: - 外部控制函数
    //==========================================================================================================

    /// 获得文件路径
    static let filePath = "useraccount.plist".cachesDir()
    
    /**
     保存用户数据
     */
    func saveAccount() -> Bool
    {
        /**
         归档
         */
        return NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
    }
    
    /// 定义属性保存授权模型
    static var account: UserAccount?
    
    /**
     加载用户数据
     */
    class func loadUserAccount() -> UserAccount?
    {
        // 1.判断是否已经加载过
        if UserAccount.account != nil
        {
            myLog("已经加载过")
            return nil
        }
        // 2.没有加载
        // 2.1解归档对象
        guard let account = NSKeyedUnarchiver.unarchiveObjectWithFile(UserAccount.filePath) as? UserAccount else
        {
            return UserAccount.account
        }
        
        // 2.3校验是否过期
        /*
        guard let date = account.expires_date else
        {
            return nil
        }
        
        if date.compare(NSDate()) == NSComparisonResult.OrderedAscending
        {
            myLog("过期了")
            return nil
        }
        */
        
        guard let date = account.expires_date where date.compare(NSDate()) != NSComparisonResult.OrderedAscending else
        {
            myLog("过期了")
            return nil
        }
        
     
        // 3.保存最新的用户数据
        UserAccount.account = account
        
        return UserAccount.account
    }
    
    /**
     判断用户是否登录
     */
    class func isLogin() -> Bool
    {
        return UserAccount.loadUserAccount() != nil
    }
    
    //==========================================================================================================
    // MARK: - NSCoding
    //==========================================================================================================
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeInteger(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeIntegerForKey("expires_in") as Int
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
    }

}

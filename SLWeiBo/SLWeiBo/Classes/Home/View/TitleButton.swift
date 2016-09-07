//
//  TitleButton.swift
//  SLWeiBo
//
//  Created by Anthony on 16/9/7.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    /**
     设置按钮的基本属性
     */
    private func setupUI() -> Void
    {
        setImage(UIImage.init(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage.init(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        
        setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        sizeToFit()
    }
    
    
    /**
     重写设置标题文字
     */
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle((title ?? "") + "  ", forState: state)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        titleLabel?.frame.offsetInPlace(dx: -imageView!.frame.width * 0.5, dy: 0)
//        imageView?.frame.offsetInPlace(dx: titleLabel!.frame.width * 0.5, dy: 0)
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.width
    }
}

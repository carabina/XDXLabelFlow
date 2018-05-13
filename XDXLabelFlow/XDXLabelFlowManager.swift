//
//  XDXLabelFlowManager.swift
//  XDXLabelFlow
//
//  Created by Chong Xie on 2018/5/11.
//  Copyright © 2018年 6谢侠6 (6xieapplexia6). All rights reserved.
//

import UIKit

public final class XDXLabelFlowManager: NSObject
{
    public static let shared = XDXLabelFlowManager()
    
    public var contentInsets: UIEdgeInsets?
    
    public var itemLabelTextFont: UIFont?
    
    public var labelTextMargin: CGFloat?
    public var gapBetweenLines: CGFloat?
    public var gapBetweenItems: CGFloat?
    public var itemHeight: CGFloat?
    public var itemCornerRadius: CGFloat?
    public var itemBackgroundColor: UIColor?
    public var itemLabelTextColor: UIColor?
    public var backgroundColor: UIColor?
    
    private override init()
    {
        super.init()
    }
}

//
//  XDXLabelFlowItem.swift
//  XDXLabelFlow
//
//  Created by Chong Xie on 2018/5/11.
//  Copyright © 2018年 6谢侠6 (6xieapplexia6). All rights reserved.
//

import UIKit

internal class XDXLabelFlowItem: UICollectionViewCell
{
    var titleLabel: UILabel = UILabel()
    
    override private init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    internal func setupTitleLabel(backgroundColor: UIColor,
                                  textColor: UIColor,
                                  font: UIFont,
                                  cornerRadius: CGFloat,
                                  textAlignment: NSTextAlignment = .center)
    {
        titleLabel.backgroundColor = backgroundColor
        titleLabel.textColor = textColor
        titleLabel.font = font
        titleLabel.layer.cornerRadius = cornerRadius
        titleLabel.textAlignment = textAlignment
        
        contentView.addSubview(titleLabel)
    }
    
    func configureItem(with title: String)
    {
        titleLabel.frame = bounds
        titleLabel.text = title
    }
}

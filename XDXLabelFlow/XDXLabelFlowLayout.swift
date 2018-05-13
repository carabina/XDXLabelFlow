//
//  XDXLabelFlowLayout.swift
//  XDXLabelFlow
//
//  Created by Chong Xie on 2018/5/11.
//  Copyright © 2018年 6谢侠6 (6xieapplexia6). All rights reserved.
//

import UIKit

@objc internal protocol XDXLabelFlowLayoutDataSource: NSObjectProtocol
{
    @objc func titleForLabel(at indexPath: IndexPath) -> String
}

@objc internal protocol XDXLabelFlowLayoutDelegate: NSObjectProtocol
{
    @objc optional func layoutFinishWithNumberOfLine(_ number: Int)
}

internal struct CurrentOrigin
{
    var lineX: CGFloat
    var lineNumber: Int
    
    init(_ lineX: CGFloat, _ lineNumber: Int)
    {
        self.lineX = lineX
        self.lineNumber = lineNumber
    }
}

internal class XDXLabelFlowLayout: UICollectionViewFlowLayout
{
    weak var labelFlow: XDXLabelFlow!
    weak var dataSource: XDXLabelFlowLayoutDataSource?
    weak var delegate: XDXLabelFlowLayoutDelegate?
    
    var itemsCount: Int!
    var origin: CurrentOrigin!
    
    override func prepare()
    {
        super.prepare()
        itemsCount = collectionView!.numberOfItems(inSection: 0)
        origin = CurrentOrigin(labelFlow.contentInsets.left, 0)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        if let attributes = super.layoutAttributesForElements(in: rect)
        {
            // Reference: UICollectionViewFlowLayout has cached frame mismatch for index path <NSIndexPath: 0x60000023f6e0>
            // {length = 2, path = 0 - 3} - cached value: {{112.14111328125, 45}, {72.55859375, 25}}; expected value: {{206, 0}, {50, 50}}
            // This is likely occurring because the flow layout subclass XDXLabelFlow.XDXLabelFlowLayout
            // is modifying attributes returned by UICollectionViewFlowLayout without copying them
            var attributes_copy = [UICollectionViewLayoutAttributes]()
            for attribute in attributes { attributes_copy.append(attribute.copy() as! UICollectionViewLayoutAttributes) }
            
            for i in 0 ..< attributes_copy.count
            {
                let att = attributes_copy[i]
                let indexPath = IndexPath(item: i, section: 0)
                let title = dataSource!.titleForLabel(at: indexPath)
                let size = self.getSize(with: title, font: labelFlow.itemTextFont)
                let itemOriginX = origin.lineX
                let itemOriginY = CGFloat(origin.lineNumber) * (labelFlow.itemHeight + labelFlow.gapBetweenLines) + labelFlow.contentInsets.top
                var itemWidth = size.width + labelFlow.labelTextMargin
                
                if itemWidth > collectionView!.frame.width - (labelFlow.contentInsets.left + labelFlow.contentInsets.right)
                {
                    itemWidth = collectionView!.frame.width - (labelFlow.contentInsets.left + labelFlow.contentInsets.right)
                }
                
                att.frame = CGRect(x: itemOriginX, y: itemOriginY, width: itemWidth, height: labelFlow.itemHeight)
                origin.lineX += itemWidth + labelFlow.gapBetweenItems
                
                if i < attributes_copy.count - 1
                {
                    let nextIndexPath = IndexPath(item: i + 1, section: 0)
                    let nextTitle = dataSource!.titleForLabel(at: nextIndexPath)
                    let nextSize = self.getSize(with: nextTitle, font: labelFlow.itemTextFont)
                    
                    if nextSize.width + labelFlow.labelTextMargin > collectionView!.frame.width - labelFlow.contentInsets.right - origin.lineX
                    {
                        origin.lineNumber += 1
                        origin.lineX = labelFlow.contentInsets.left
                    }
                }
                else
                {
                    delegate?.layoutFinishWithNumberOfLine?(origin.lineNumber + 1)
                }
            }
            
            return attributes_copy
        }
        else
        {
            return nil
        }
    }
    
    private func getSize(with title: String, font: UIFont) -> CGSize
    {
        let dic = [NSAttributedStringKey.font: font]
        let rect: CGRect = (title as NSString).boundingRect(with: CGSize(width: 1000,
                                                                         height: labelFlow.itemHeight),
                                                            options: [.truncatesLastVisibleLine,
                                                                      .usesFontLeading,
                                                                      .usesLineFragmentOrigin],
                                                            attributes: dic,
                                                            context: nil)
        return rect.size
    }
}

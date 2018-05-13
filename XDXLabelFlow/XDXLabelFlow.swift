//
//  XDXLabelFlow.swift
//  XDXLabelFlow
//
//  Created by Chong Xie on 2018/5/7.
//  Copyright © 2018年 6谢侠6 (6xieapplexia6). All rights reserved.
//

import UIKit

@IBDesignable public class XDXLabelFlow: UIView,
                                         UICollectionViewDataSource,
                                         UICollectionViewDelegate,
                                         XDXLabelFlowLayoutDataSource,
                                         XDXLabelFlowLayoutDelegate
{
    @IBInspectable public var contentInsetTop: CGFloat    = XDXLabelFlowManager.shared.contentInsets?.top    ?? 10
    @IBInspectable public var contentInsetLeft: CGFloat   = XDXLabelFlowManager.shared.contentInsets?.left   ?? 15
    @IBInspectable public var contentInsetBottom: CGFloat = XDXLabelFlowManager.shared.contentInsets?.bottom ?? 10
    @IBInspectable public var contentInsetRight: CGFloat  = XDXLabelFlowManager.shared.contentInsets?.right  ?? 15
    
    @IBInspectable public var itemTextFontName: String  = XDXLabelFlowManager.shared.itemLabelTextFont?.fontName  ?? UIFont.systemFont(ofSize: 15).fontName
    @IBInspectable public var itemTextFontSize: CGFloat = XDXLabelFlowManager.shared.itemLabelTextFont?.pointSize ?? 15
    
    @IBInspectable public var labelTextMargin: CGFloat     = XDXLabelFlowManager.shared.labelTextMargin     ?? 20
    @IBInspectable public var gapBetweenLines: CGFloat     = XDXLabelFlowManager.shared.gapBetweenLines     ?? 10
    @IBInspectable public var gapBetweenItems: CGFloat     = XDXLabelFlowManager.shared.gapBetweenItems     ?? 10
    @IBInspectable public var itemHeight: CGFloat          = XDXLabelFlowManager.shared.itemHeight          ?? 25
    @IBInspectable public var itemCornerRadius: CGFloat    = XDXLabelFlowManager.shared.itemCornerRadius    ?? 3
    @IBInspectable public var itemBackgroundColor: UIColor = XDXLabelFlowManager.shared.itemBackgroundColor ?? .white
    @IBInspectable public var itemLabelTextColor: UIColor  = XDXLabelFlowManager.shared.itemLabelTextColor  ?? .darkText
    
    public var contentInsets: UIEdgeInsets {
        get { return UIEdgeInsets(top: contentInsetTop, left: contentInsetLeft, bottom: contentInsetBottom, right: contentInsetRight) }
    }
    public var itemTextFont: UIFont {
        get { return UIFont(name: itemTextFontName, size: itemTextFontSize) ?? UIFont.systemFont(ofSize: 15) }
    }
    
    private var collection: UICollectionView!
    private var data: [String]
    private var handler: ((Int, String) -> Void)?
    
    internal static let cellID: String = "cellID"
    
    public init(frame: CGRect, titles: [String], handler: ((Int, String) -> Void)? = nil)
    {
        self.data = titles
        self.handler = handler
        
        super.init(frame: frame)
        self.backgroundColor = XDXLabelFlowManager.shared.backgroundColor ?? UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        self.data = []
        super.init(coder: aDecoder)
    }
    
    public func set(data: [String], handler: ((Int, String) -> Void)? = nil)
    {
        self.data = data
        self.handler = handler
        setup()
    }
    
    override public func prepareForInterfaceBuilder()
    {
        super.prepareForInterfaceBuilder()
        data = ["Apple", "Google", "Microsoft", "Visa", "MasterCard", "American Express"]
        setup()
    }
    
    private func setup()
    {
        let layout = XDXLabelFlowLayout()
        layout.labelFlow = self
        layout.dataSource = self
        layout.delegate = self
        collection = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.allowsMultipleSelection = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(XDXLabelFlowItem.self, forCellWithReuseIdentifier: XDXLabelFlow.cellID)
        addSubview(collection)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XDXLabelFlow.cellID, for: indexPath) as! XDXLabelFlowItem
        cell.setupTitleLabel(backgroundColor: itemBackgroundColor,
                             textColor: itemLabelTextColor,
                             font: itemTextFont,
                             cornerRadius: itemCornerRadius)
        cell.configureItem(with: data[indexPath.item])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        handler?(indexPath.item, data[indexPath.item])
    }
    
    public func titleForLabel(at indexPath: IndexPath) -> String
    {
        return data[indexPath.item]
    }
    
    private var numberCount: Int?
    
    internal func layoutFinishWithNumberOfLine(_ number: Int)
    {
        if numberCount == number { return }
        numberCount = number
        
        let height = contentInsets.top + contentInsets.bottom + itemHeight * CGFloat(number) + gapBetweenLines * CGFloat(number - 1)
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: height)
        UIView.animate(withDuration: 0.2) {
            self.collection.frame = self.bounds
        }
    }
    
    public func insertLabel(with title: String, at index: Int, animated: Bool)
    {
        let indexPath = IndexPath(item: index, section: 0)
        data.insert(title, at: index)
        performBatchUpdates(with: .insert, indexPath: indexPath, animated: animated)
    }
    
    public func deleteLabel(at index: Int, animated: Bool)
    {
        let indexPath = IndexPath(item: index, section: 0)
        data.remove(at: index)
        performBatchUpdates(with: .delete, indexPath: indexPath, animated: animated)
    }
    
    public func reloadAll(with titles: [String])
    {
        for (index, _) in data.enumerated().reversed()
        {
            deleteLabel(at: index, animated: true)
        }
        
        for (index, title) in titles.enumerated()
        {
            insertLabel(with: title, at: index, animated: true)
        }
    }
    
    private func performBatchUpdates(with action: UICollectionUpdateAction, indexPath: IndexPath, animated: Bool)
    {
        UIView.setAnimationsEnabled(animated)
        
        collection.performBatchUpdates({
            switch action {
            case .insert: collection.insertItems(at: [indexPath])
            case .delete: collection.deleteItems(at: [indexPath])
            default: break
            }
        }) { (finished) in
            UIView.setAnimationsEnabled(true)
        }
    }
}

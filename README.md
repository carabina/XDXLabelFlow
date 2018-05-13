# XDXLabelFlow

![logo](https://raw.githubusercontent.com/6xieapplexia6/XDXResources/master/XDXLabelFlow_intro.png)
<br/><br/>
![Version](https://img.shields.io/cocoapods/v/XDXLabelFlow.svg?style=plastic)
![Platform](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=plastic)
![Languages](https://img.shields.io/badge/language-swift%20|%20objc-FF69B4.svg?style=plastic)
![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=plastic)

## Table of contents - 目录
* [Introduction](#introduction)
* [Installation](#installation)
* [Tips](#tips)
* [简介](#introductionCHS)
* [安装说明](#installationCHS)
* [使用技巧](#tipsCHS)
* [Support XDXLabelFlow](#support)
* [Contact](#contact)
* [License](#license)

### <a id="introduction"></a>Introduction

The GitHub repo [XDXLabelFlow](https://github.com/6xieapplexia6/XDXLabelFlow) was originally inspired by [MSSAutoresizeLabelFlow](https://github.com/ZhuPeng1314/MSSAutoresizeLabelFlow) written by GitHub user [ZhuPeng1314](https://github.com/ZhuPeng1314) with the differences and enhancements of: 

1. Written in Swift 4.1 other than Objective-C;
2. @IBDesignable class and @IBInspectable attributes so developers can set the attributes and preview the UI behaviors in Xcode storyboard or xib files;
3. The availability of CocoaPods installation;
4. Easier to use compared with [MSSAutoresizeLabelFlow](https://github.com/ZhuPeng1314/MSSAutoresizeLabelFlow).

### <a id="installation"></a>Installation
The easiest way to install this API on an iOS project is to copy all the files whose type are .swift into the Xcode project folder.

Cocoapods installation:
```Ruby
target '<your_project>' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for <your_project>
  pod 'XDXLabelFlow'
end
```

### <a id="tips"></a>Tips

#### Setup Steps

1. In xib / storyboard file, drag a UIView into a view and rename the class to XDXLabelFlow.
2. Link the XDXLabelFlow object to the class. Example: 
```swift
@IBOutlet weak var labelFlow: XDXLabelFlow!
```
3. Use set(data: [String], handler: ((Int, String) -> Void)? = nil) method, then the XDXLabelFlow instance is ready to display and respond to tapping events. Example: 
```swift
labelFlow.set(data: ["Apple", "Google", "Microsoft", "Visa", "MasterCard", "American Express"]) { (index, title) in
    print("The selected title is \(title) in index \(index)")
}
```

Note: For all the methods below, please using them after view has appeared in the screen to avoid crash.

4. Use insertLabel(with title: String, at index: Int, animated: Bool) method to insert label(s). Example:
```swift
labelFlow.insertLabel(with: "Alibaba", at: 3, animated: true)
```
5. Use deleteLabel(at index: Int, animated: Bool) method to delete label(s). Example:
```swift
labelFlow.deleteLabel(at: 3, animated: true)
```
6. Use reloadAll(with titles: [String]) method to reload all titles. Example:
```swift
labelFlow.reloadAll(with: ["Visa", "MasterCard", "American Express", "JCB", "UnionPay"])
```

#### Global Configuration

XDXLabelFlowManager is a class containing a singleton instance for configuring all XDXLabelFlow instances in the project. Let's have an example:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool 
{
    configXDXLabelFlowGlobally()
    return true
}

func configXDXLabelFlowGlobally()
{
    XDXLabelFlowManager.shared.contentInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    XDXLabelFlowManager.shared.itemLabelTextFont = UIFont.systemFont(ofSize: 15)
    XDXLabelFlowManager.shared.labelTextMargin = 20
    XDXLabelFlowManager.shared.gapBetweenLines = 10
    XDXLabelFlowManager.shared.gapBetweenItems = 10
    XDXLabelFlowManager.shared.itemHeight = 25
    XDXLabelFlowManager.shared.itemCornerRadius = 3
    XDXLabelFlowManager.shared.itemBackgroundColor = .white
    XDXLabelFlowManager.shared.itemLabelTextColor = .darkText
    XDXLabelFlowManager.shared.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
}
```

Simply copy this piece of code and do a little modification based on what you need in the project's AppDelegate file. So you don't have to override either in coding files or in xib / storyboard files everytime when XDXLabelFlow is created. All variables in XDXLabelFlowManager are optional, so you are not required to do this in AppDelegate.

### <a id="introductionCHS"></a>简介

该 GitHub 仓库 [XDXLabelFlow](https://github.com/6xieapplexia6/XDXLabelFlow) 是基于 [ZhuPeng1314](https://github.com/ZhuPeng1314) 的仓库 [MSSAutoresizeLabelFlow](https://github.com/ZhuPeng1314/MSSAutoresizeLabelFlow) 改编并强化之作：

1. 用 Swift 4.1 编写，而不是 Objective-C;
2. @IBDesignable 和 @IBInspectable 可以让开发者设置 XDXLabelFlow 的属性并预览 UI 效果；
3. 可以使用 CocoaPods 导入至项目中；
4. 相比起 [MSSAutoresizeLabelFlow](https://github.com/ZhuPeng1314/MSSAutoresizeLabelFlow) 更简单易用。

### <a id="installationCHS"></a>安装说明
把 XDXLabelFlow 安装到 iOS 项目的最简单的方式可以是直接把目录下所有 .swift 文件复制到 iOS 项目的 Xcode 项目文件夹中。

Cocoapods 安装：
```Ruby
target '<你的项目名>' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks! 

  # Pods for <你的项目名>
  pod 'XDXLabelFlow'
end
```

### <a id="tipsCHS"></a>使用技巧

#### 上手步骤

1. 在 xib / storyboard 编辑器中, 引入 UIView 并重命名为 XDXLabelFlow。
2. 把 XDXLabelFlow 连入类的代码中。如以下代码所示： 
```swift
@IBOutlet weak var labelFlow: XDXLabelFlow!
```
3. 使用 set(data: [String], handler: ((Int, String) -> Void)? = nil) 方法，之后 XDXLabelFlow 实例就可以正确显示并响应点击事件了。如以下代码所示： 
```swift
labelFlow.set(data: ["Apple", "Google", "Microsoft", "Visa", "MasterCard", "American Express"]) { (index, title) in
    print("The selected title is \(title) in index \(index)")
}
```

注意事项：请在 view 显示在屏幕之后再调用以下方法以避免系统奔溃。

4. 使用 insertLabel(with title: String, at index: Int, animated: Bool) 方法来插入标签。如以下代码所示：
```swift
labelFlow.insertLabel(with: "Alibaba", at: 3, animated: true)
```
5. 使用 deleteLabel(at index: Int, animated: Bool) method 方法来删除标签。如以下代码所示：
```swift
labelFlow.deleteLabel(at: 3, animated: true)
```
6. 使用 reloadAll(with titles: [String]) 方法来重新加载所有标签。如以下代码所示：
```swift
labelFlow.reloadAll(with: ["Visa", "MasterCard", "American Express", "JCB", "UnionPay"])
```

#### 全局设置

类 XDXLabelFlowManager 包含了一个单例来配置所有在项目中的 XDXLabelFlow 实例。示例如下：

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool 
{
    configXDXLabelFlowGlobally()
    return true
}

func configXDXLabelFlowGlobally()
{
    XDXLabelFlowManager.shared.contentInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    XDXLabelFlowManager.shared.itemLabelTextFont = UIFont.systemFont(ofSize: 15)
    XDXLabelFlowManager.shared.labelTextMargin = 20
    XDXLabelFlowManager.shared.gapBetweenLines = 10
    XDXLabelFlowManager.shared.gapBetweenItems = 10
    XDXLabelFlowManager.shared.itemHeight = 25
    XDXLabelFlowManager.shared.itemCornerRadius = 3
    XDXLabelFlowManager.shared.itemBackgroundColor = .white
    XDXLabelFlowManager.shared.itemLabelTextColor = .darkText
    XDXLabelFlowManager.shared.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
}
```

复制以上代码到 iOS 项目的 AppDelegate 文件中，并根据需要作出修改。就不需要每次都在代码、xib 或 storyboard 文件重新配置 XDXLabelFlow 了。该类内都是 optional 变量，所以以上代码并不需要出现在 iOS 项目中。

### <a id="support"></a>Support XDXLabelFlow
* [**★Star**](#) this repo

### <a id="contact"></a>Contact
* LinkedIn： [**@Chong Xie**](https://www.linkedin.com/in/chongx)

### License
XDXLabelFlow is available under the MIT license. Please see the LICENSE file for more info.
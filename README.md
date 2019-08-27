![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![License](https://img.shields.io/badge/license-mit-blue.svg)](https://doge.mit-license.org)

## Overview
This is a Swift version of [STCollapseTableView](https://github.com/iSofTom/STCollapseTableView) that was written in Objective-C. 

CollapseTableView enables you to make expandable UITableView's sections with just a few lines of code.

## Presentation
<p align="left">
<img src="https://github.com/Kharauzov/CollapseTableView/blob/master/collapseTableViewDemo.gif" width="250px" height="472px"/>
</p>

## Installation

### CocoaPods

```ruby
pod 'CollapseTableView'
```

### Manually

Just copy **Source** folder to your Xcode project.

## How To

After adding the framework to your project, you need to import the module
```swift
import CollapseTableView
```

Then you need to subclass your *UITableView* with *CollapseTableView* and set delegate/datasource as you always do. 
By default, tableView sections are clickable and expandable. 

If you want to disable clickability of sections, there is a special property for this:

```swift
public var shouldHandleHeadersTap: Bool
```

So after you implement standard tableView's dataSource/delegate methods for sections, you will be able to open or close the sections with your cells by clicking them.

There're extra tableView methods for work with sections:

```swift
public func toggleSection(_ sectionIndex: Int, animated: Bool)
public func openSection(_ sectionIndex: Int, animated: Bool)
public func closeSection(_ sectionIndex: Int, animated: Bool)
public func isOpenSection(_ sectionIndex: Int) -> Bool
```

There's a closure to observe events for opening/closing sections:
```swift
tableView.didTapSectionHeaderView = { (sectionIndex, isOpen) in
  
}
```

## Features
- [ ] Exlusive sections mode (Max 1 opened section)

## Feedback
If you have any questions or suggestions, feel free to open issue just at this project.

## License
CollapseTableView and all its classes are available under the MIT license. See the LICENSE file for more info.

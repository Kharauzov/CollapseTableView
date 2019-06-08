![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![License](https://img.shields.io/badge/license-mit-blue.svg)](https://doge.mit-license.org)

## Overview
This is a Swift version of [STCollapseTableView](https://github.com/iSofTom/STCollapseTableView) that was written in Objective-C. 

CollapseTableView enables you to make expandable UITableView's sections with just a few lines of code.

## Presentation
<p align="left">
<img src="https://github.com/Kharauzov/CollapseTableView/blob/master/CollapseTableView.gif" width="250px" height="480px"/>
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

So after you implement standard tableView's dataSource/delegate methods for sections, you will be able to open or close the sections with your cells by clicking them.

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

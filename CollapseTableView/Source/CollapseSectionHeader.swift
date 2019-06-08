//
//  CollapseSectionHeader.swift
//  CollapseTableView
//
//  Created by Serhii Kharauzov on 6/7/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

public protocol CollapseSectionHeader {
    /// Shows open/close state of section.
    var indicatorImageView: UIImageView { get }
    /// Default value is 0.25.
    var imageAnimationDuration: TimeInterval { get }
    
    /// Default implementation: rotates `indicatorImageView` in
    /// appropriate direction.
    func handleChangeToOpenState()
    /// Default implementation: rotates `indicatorImageView` in
    /// appropriate direction.
    func handleChangeToCloseState()
}

// MARK: Default implementation of methods and properties.

/// One can override them in own custom view, adopting `CollapseSectionHeader` protocol.

extension CollapseSectionHeader {
    public var imageAnimationDuration: TimeInterval {
        return 0.25
    }
    
    public func handleChangeToOpenState() {
        UIView.animate(withDuration: imageAnimationDuration) {
            self.indicatorImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    
    public func handleChangeToCloseState() {
        UIView.animate(withDuration: imageAnimationDuration) {
            self.indicatorImageView.transform = CGAffineTransform(rotationAngle: CGFloat(2 * Double.pi))
        }
    }
}

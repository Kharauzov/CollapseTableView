//
//  SectionHeaderView.swift
//  CollapseTableView
//
//  Created by Serhii Kharauzov on 6/7/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import UIKit
import CollapseTableView

class SectionHeaderView: UIView, CollapseSectionHeader {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var indicatorImageView: UIImageView {
        return imageView
    }
}

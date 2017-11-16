//
//  DataItemHeader.swift
//  TeamCollectionViewDemo
//
//  Created by Robert Berry on 11/15/17.
//  Copyright © 2017 Robert Berry. All rights reserved.
//

import UIKit

class DataItemHeader: UICollectionReusableView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
} 

//
//  DataItem.swift
//  TeamCollectionViewDemo
//
//  Created by Robert Berry on 11/15/17.
//  Copyright © 2017 Robert Berry. All rights reserved.
//

import Foundation
import UIKit

class DataItem {
    
    var title: String
    var kind: Kind
    var imageName: String
    
    init(title: String, kind: Kind, imageName: String) {
        self.title = title
        self.kind = kind
        self.imageName = imageName
    }
}

enum Kind: Int {
    case GoodTeam
    case BadTeam
    
    func description() -> String {
        switch self {
        case .GoodTeam:
            return "Good Teams"
        case .BadTeam:
            return "Bad Teams"
        }
    }
}

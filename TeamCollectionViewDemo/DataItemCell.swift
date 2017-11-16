//
//  DataItemCell.swift
//  TeamCollectionViewDemo
//
//  Created by Robert Berry on 11/15/17.
//  Copyright © 2017 Robert Berry. All rights reserved.
//

import UIKit

protocol PhotoCellDelegate: class {
    func delete(cell: DataItemCell)
}

class DataItemCell: UICollectionViewCell {
    
    // Outlets
   
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!
    @IBOutlet private weak var dataItemImageView: UIImageView!
    
    weak var delegate: PhotoCellDelegate?
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        
        delegate?.delete(cell: self)
    }
    
    // A didSet observer is used here. When the cell's DataItem is set, extract the image and set that on the imageview.
    
    var dataItem: DataItem? {
        didSet {
            if let dataItem = dataItem {
                dataItemImageView.image = UIImage(named: dataItem.imageName)
            }
            
            // Makes delete button in cell round instead of square.
            
            deleteButtonBackgroundView.layer.cornerRadius = deleteButtonBackgroundView.bounds.width / 2.0
            deleteButtonBackgroundView.layer.masksToBounds = true
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    
    // Variable to determine if we are in editing mode for cell.
    
    var isEditing: Bool = false {
        didSet {
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
}

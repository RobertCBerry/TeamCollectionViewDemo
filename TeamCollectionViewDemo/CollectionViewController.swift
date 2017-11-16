//
//  CollectionViewController.swift
//  TeamCollectionViewDemo
//
//  Created by Robert Berry on 11/15/17.
//  Copyright © 2017 Robert Berry. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    // Variables
    
    var goodTeamDataItems = [DataItem]()
    var badTeamDataItems = [DataItem]()
    var allItems = [[DataItem]]()
    
    // Outlet For Add Button
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem! 
    
    // Add Button: Code adds collection view item to first section, [0]. 
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let item = DataItem(title: "New Team", kind: .GoodTeam, imageName: "default.jpeg")
        let index = allItems[0].count
        allItems[0].append(item)
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.insertItems(at: [indexPath])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adjusts cell size to fit screen for any given device.
        
        let width = collectionView!.frame.width / 2
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        // Adds leftBarButtonItem to navigationItem.
        
        navigationItem.leftBarButtonItem = editButtonItem

        // For-Loop populates the goodTeamDataItems array with four DataItem objects.
       
        for i in 1...4 {
            goodTeamDataItems.append(DataItem(title: "Good Team #\(i)", kind: Kind.GoodTeam, imageName: "GoodTeam\(i)"))
            }
        
        // For-Loop populates the badTeamDataItems array with four DataItem objects.
        
        for i in 1...4 {
            badTeamDataItems.append(DataItem(title: "Bad Team #\(i)", kind: Kind.BadTeam, imageName: "BadTeam\(i)"))
        }
        
        allItems.append(goodTeamDataItems)
        allItems.append(badTeamDataItems)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    // Method that returns the number of sections in the CollectionViewController.
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItems[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DataItemCell
        let dataItem = allItems[indexPath.section][indexPath.row]
        cell.dataItem = dataItem
        
        cell.delegate = self
        
        return cell
    }
    
    // Method dequeues the reusable header view and adds a title to it.
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! DataItemHeader
        var title = ""
        if let kind = Kind(rawValue: indexPath.section) {
            title = kind.description()
        }
        sectionHeader.title = title
        
        return sectionHeader
    }

    // MARK: Methods to move cells around.
    
    // Enables the use of moving items in the UICollectionView.
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Method to intercept the starting index and the ending index of both of the items that are switching places.
   
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movingCell = allItems[sourceIndexPath.section][sourceIndexPath.row]
        
        allItems[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        
        if sourceIndexPath.section == destinationIndexPath.row {
            
            
            allItems[destinationIndexPath.section].insert(movingCell, at: destinationIndexPath.row)
            
        } else {
            
            allItems[destinationIndexPath.section].insert(movingCell, at: destinationIndexPath.row)
            
            if destinationIndexPath.section == 0 {
                movingCell.kind = Kind.GoodTeam
            } else {
                movingCell.kind = Kind.BadTeam
            }
        }
        
        collectionView.reloadData()
    }
 
    // MARK: Delete Items
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        // Code makes it so that add button is disabled when trying to delete items.
        
        addBarButtonItem.isEnabled = !editing
        
        // Enables editing of all visible items in collection view.
        
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? DataItemCell {
                    cell.isEditing = editing
                }
            }
        }
    }
}

// Extension that makes CollectionViewController conform to PhotoCellDelegate. 

extension CollectionViewController: PhotoCellDelegate {
    
    func delete(cell: DataItemCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            
            // 1. Delete photo from data source.
            self.allItems[indexPath.section].remove(at: indexPath.row)
            
            // 2. Delete cell from specified index path in collection view.
            collectionView?.deleteItems(at: [indexPath])
        }
    }
}

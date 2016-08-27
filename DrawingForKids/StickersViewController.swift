//
//  StickersViewController.swift
//  DrawingForKids
//
//  Created by Adey Salyards on 8/9/16.
//  Copyright © 2016 Adey Salyards. All rights reserved.
//

import UIKit

struct Sticker {
    let displayName: String
    let color: UIColor
    
}

class StickersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

   private let stickers = [
    Sticker(displayName: "basketball", color: UIColor.rgb(100, green: 200, blue: 300)),
    Sticker(displayName: "shoe", color: UIColor.blueColor()),
    Sticker(displayName: "bicycle", color: UIColor.yellowColor()),
    Sticker(displayName: "sun", color: UIColor.purpleColor()),
    Sticker(displayName: "jumprope", color: UIColor.orangeColor()),
    Sticker(displayName: "hand", color: UIColor.magentaColor()),
    Sticker(displayName: "ear", color: UIColor.brownColor()),
    Sticker(displayName: "milk", color: UIColor.cyanColor()),
    Sticker(displayName: "apple", color: UIColor.redColor()),
    Sticker(displayName: "water", color: UIColor.blackColor()),
    ]
    var selectedCell: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Stickers"
        
        collectionView?.backgroundColor = UIColor.whiteColor()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        cell.backgroundColor = stickers[indexPath.row].color
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width/3, 100)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
       	 selectedCell = indexPath
        performSegueWithIdentifier("stickersSegue", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stickersSegue" {
            var drawingViewController: DrawingViewController!

            if let drawingNavigationController = segue.destinationViewController as? UINavigationController {
                drawingViewController = drawingNavigationController.topViewController as? DrawingViewController
                drawingViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                drawingViewController.navigationItem.leftItemsSupplementBackButton = true
                
                let color = stickers[(selectedCell?.row)!]
                drawingViewController.colorStruct = color
            } else {
                drawingViewController = segue.destinationViewController as! DrawingViewController
            };
            
            if let selectedRowIndexPath = collectionView?.indexPathsForSelectedItems() {
                
            }
        }
    }
}
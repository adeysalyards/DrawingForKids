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
    Sticker(displayName: "basketball", color: UIColor.greenColor()),
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Stickers"
        
        collectionView?.backgroundColor = UIColor.whiteColor()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("there are this many stickers:", stickers.count)
        return stickers.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.blackColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width/3, 100)
    }
}
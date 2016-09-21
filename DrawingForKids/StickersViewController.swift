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
    let image: UIImage
    
    init(displayName: String, image: UIImage) {
        self.displayName = displayName
        self.image = image
    }
    
}

class StickersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

   private let stickers = [
    Sticker(displayName: "basketball", image: UIImage(named: "Basketball")!),
    Sticker(displayName: "shoe", image: UIImage(named: "Shoe")!),
    Sticker(displayName: "bicycle", image: UIImage(named: "Bike")!),
    Sticker(displayName: "sun", image: UIImage(named: "Sun")!),
    Sticker(displayName: "jumprope", image: UIImage(named: "Jump Rope")!),
    Sticker(displayName: "hand", image: UIImage(named: "Hand")!),
    Sticker(displayName: "ear", image: UIImage(named: "Ear")!),
    Sticker(displayName: "milk", image: UIImage(named: "Milk")!),
    Sticker(displayName: "apple", image: UIImage(named: "Apple")!),
    Sticker(displayName: "water", image: UIImage(named: "Water")!),
    ]

    
    var selectedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Stickers"
        collectionView?.backgroundColor = UIColor.rgb(97, green: 97, blue: 97)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MyCellCollectionViewCell
        
//        cell.stickerImage.image = basketballStickerImage.image
        cell.stickerImage.image = stickers[indexPath.row].image
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width/3, 100)
    }

    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCell", forIndexPath: indexPath) as! HeaderCollectionReusableView
            header.backgroundColor = UIColor.rgb(130, green: 211, blue: 138)
            
            let squiggleImageview = UIView()
            squiggleImageview.alpha = 0.2
            squiggleImageview.frame = header.frame
            let image = header.squiggleImage.image!
            let scaled = UIImage(CGImage: image.CGImage!, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)
            squiggleImageview.backgroundColor = UIColor(patternImage: scaled)
            header.insertSubview(squiggleImageview, atIndex: 1)
            
            header.backgroundForLabelView.layer.cornerRadius = header.backgroundForLabelView.frame.height/2
            return header
        
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        selectedImage.image = stickers[indexPath.row].image
    }
    
    @IBAction func didTapSticker(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        
        selectedImage = UIImageView(image: imageView.image)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stickersSegue" {
            var drawingViewController: DrawingViewController!

            if let drawingNavigationController = segue.destinationViewController as? UINavigationController {
                drawingViewController = drawingNavigationController.topViewController as? DrawingViewController
                drawingViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                drawingViewController.navigationItem.leftItemsSupplementBackButton = true
                drawingViewController.newlyAddedSticker = selectedImage
                
//                drawingViewController.colorStruct = color
            } else {
                drawingViewController = segue.destinationViewController as! DrawingViewController
            };
            
            if let selectedRowIndexPath = collectionView?.indexPathsForSelectedItems() {
                
            }
        }
    }
}
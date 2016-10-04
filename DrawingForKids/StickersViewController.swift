//
//  StickersViewController.swift
//  DrawingForKids
//
//  Created by Adey Salyards on 8/9/16.
//  Copyright © 2016 Adey Salyards. All rights reserved.
//

import UIKit
import AVFoundation

struct Sticker {
    let displayName: String
    let image: UIImage
    
    init(displayName: String, image: UIImage) {
        self.displayName = displayName
        self.image = image
    }
    
}

class StickersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

   fileprivate let stickers = [
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

    
    var selectedImage = UIImageView()
    var myAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(splitViewController?.viewControllers)
//        splitViewController?.presentsWithGesture = false
        
        
        navigationItem.title = "Stickers"
        collectionView?.backgroundColor = UIColor.rgb(97, green: 97, blue: 97)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCellCollectionViewCell
        
        cell.stickerImage.image = stickers[(indexPath as NSIndexPath).row].image
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3, height: 100)
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCollectionReusableView
            header.backgroundColor = UIColor.rgb(130, green: 211, blue: 138)
            
            let squiggleImageview = UIView()
            squiggleImageview.alpha = 0.2
            squiggleImageview.frame = header.frame
            let image = header.squiggleImage.image!
            let scaled = UIImage(cgImage: image.cgImage!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
            squiggleImageview.backgroundColor = UIColor(patternImage: scaled)
            header.insertSubview(squiggleImageview, at: 1)
            
            header.backgroundForLabelView.layer.cornerRadius = header.backgroundForLabelView.frame.height/2
            return header
        
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {

        let myPath = Bundle.main.path(forResource: "beep-hightone.aif", ofType: nil)
        
        if let myPath = myPath {
            let url = URL(fileURLWithPath: myPath)
            
            do {
                try myAudioPlayer = AVAudioPlayer(contentsOf: url)
                myAudioPlayer.play()
            } catch {
                print("Can't play hightone sound")
            }
            
        } else {
            print("Couldn't find hightone sound")
        }
        
        let navVC = splitViewController?.viewControllers[1] as? UINavigationController
        let myDrawingVC = navVC?.topViewController as? DrawingViewController
       myDrawingVC?.newlyAddedSticker = stickers[(indexPath as NSIndexPath).item].image
        
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "stickersSegue" {
//            var drawingViewController: DrawingViewController!
//
//            if let drawingNavigationController = segue.destinationViewController as? UINavigationController {
//                drawingViewController = drawingNavigationController.topViewController as? DrawingViewController
//                drawingViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                drawingViewController.navigationItem.leftItemsSupplementBackButton = true
//                drawingViewController.newlyAddedSticker = selectedImage.image!
//                
////                drawingViewController.colorStruct = color
//            } else {
//                drawingViewController = segue.destinationViewController as! DrawingViewController
//            };
//            
//            if let selectedRowIndexPath = collectionView?.indexPathsForSelectedItems() {
//                
//            }
//        }
//    }
}

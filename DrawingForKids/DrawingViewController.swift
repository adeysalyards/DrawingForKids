//
//  DrawingViewController.swift
//  DrawingForKids
//
//  Created by Adey Salyards on 8/9/16.
//  Copyright © 2016 Adey Salyards. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var start: CGPoint!
    var newlyAddedSticker = UIImage() {
        didSet {
            makeNewSticker()
        }
    }
    
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var newSticker: UIImageView!
    var rgbColor: (CGFloat, CGFloat, CGFloat) = (116/255, 116/255, 116/255)
    @IBOutlet weak var drawImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //IF LET
//        if let image = newlyAddedSticker? {
//            print(image)
//        }
        
        buttonAppearence()
        
        drawImageView.backgroundColor = UIColor(red: 1, green: 245/255, blue: 230/255, alpha: 1)
        
    }
    
    func buttonAppearence() {
        trashButton.layer.cornerRadius = trashButton.frame.height/2
        saveButton.layer.cornerRadius = saveButton.frame.height/2
        
        
    }
    
    func makeNewSticker() {
        newSticker = UIImageView(image: newlyAddedSticker)
        view.addSubview(newSticker)
        
        //action: #selector(YourViewController.handleTap)
        let myPanGesture = UIPanGestureRecognizer(target: self, action: #selector(DrawingViewController.handleTap))
        myPanGesture.delegate = self
        newSticker.isUserInteractionEnabled = true
        newSticker.addGestureRecognizer(myPanGesture)
    }
    
    @IBAction func didPressSaveButton(_ sender: AnyObject) {
        
    }
    
    @IBAction func didPressTrashButton(_ sender: AnyObject) {
        
    }
    
    
    func handleTap(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            print("hi")
        }else if sender.state == UIGestureRecognizerState.changed {
            newSticker.center = location
        }else if sender.state == UIGestureRecognizerState.ended {
            
        }
    }
    
    @IBAction func revealDrawer(_ sender: AnyObject) {
        let navVC = splitViewController?.viewControllers[1] as? UINavigationController
        let myStickersVC = navVC?.topViewController as? StickersViewController
        myStickersVC?.willRotate(to: self.interfaceOrientation, duration: 0)
    }

    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        print("rotating")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch!
        start = touch?.location(in: self.drawImageView)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch!
        let end = touch?.location(in: self.drawImageView)
        if let s = self.start {
            draw(s, end: end!)
        }
        self.start = end
    }
    
    func draw(_ start: CGPoint, end: CGPoint){
        UIGraphicsBeginImageContext(self.drawImageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        drawImageView?.image?.draw(in: CGRect(x: 0, y: 0, width: drawImageView.frame.width, height: drawImageView.frame.height))
        
        context?.setLineWidth(6)
        context?.beginPath()
        context?.move(to: CGPoint(x: start.x, y: start.y))
//        CGContextMoveToPoint(context, start.x, start.y)
        context?.addLine(to: CGPoint(x: end.x, y: end.y))
//        CGContextAddLineToPoint(context, end.x, end.y)
        context?.setStrokeColor(red: rgbColor.0, green: rgbColor.1, blue: rgbColor.2, alpha: 1)
        context?.setLineCap(CGLineCap.round)
        context?.setLineJoin(CGLineJoin.round)
        context?.strokePath()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        drawImageView.image = newImage
    }


}

//
//  DrawingViewController.swift
//  DrawingForKids
//
//  Created by Adey Salyards on 8/9/16.
//  Copyright © 2016 Adey Salyards. All rights reserved.
//

import UIKit
import AVFoundation

class DrawingViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var start: CGPoint!
    var newlyAddedSticker = UIImage() {
        didSet {
            makeNewSticker()
        }
    }
    
//    @IBOutlet var colorButton: [UIButton]! {
//        didSet {
//            colorButton.forEach {
//                colorButton.layer.cornerRadius = 16
//                colorButton.layer.shadowColor = UIColor.black.cgColor
//                colorButton.layer.shadowOffset = CGSize(width: -2, height: 2)
//                colorButton.layer.shadowRadius = 0
//                colorButton.layer.shadowOpacity = 0.3
//
//            }
//        }
//    }
    
    @IBOutlet weak var colorButtonStackView: UIStackView!
    @IBOutlet weak var color5Button: UIButton!
    @IBOutlet weak var color4Button: UIButton!
    @IBOutlet weak var color3Button: UIButton!
    @IBOutlet weak var color2Button: UIButton!
    @IBOutlet weak var color1Button: UIButton!
    
    var myColorButtons: [UIButton]!
    
    @IBOutlet weak var grayFrame: UIView!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var newSticker: UIImageView!
    var rgbColor: (CGFloat, CGFloat, CGFloat) = (116/255, 116/255, 116/255)
    var myAudioPlayer = AVAudioPlayer()
    var color: CGColor!
    @IBOutlet weak var drawImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        color = UIColor(red: 12/255, green: 159/255, blue: 210/255, alpha: 1).cgColor
        //IF LET
//        if let image = newlyAddedSticker? {
//            print(image)
//        }
        
        myColorButtons = [color1Button, color2Button, color3Button, color4Button, color5Button]
        
        buttonAppearence()
        drawImageView.backgroundColor = UIColor(red: 1, green: 245/255, blue: 230/255, alpha: 1)
        
    }
    
    func buttonAppearence() {
        
        for UIButton in myColorButtons {
            UIButton.layer.cornerRadius = 16
            UIButton.layer.shadowColor = UIColor.black.cgColor
            UIButton.layer.shadowOffset = CGSize(width: -2, height: 2)
            UIButton.layer.shadowRadius = 0
            UIButton.layer.shadowOpacity = 0.3

        }
        
        trashButton.layer.cornerRadius = 25
        saveButton.layer.cornerRadius = 25
        
        trashButton.backgroundColor = UIColor.rgb(255, green: 127, blue: 127)
        saveButton.backgroundColor = UIColor.rgb(12, green: 159, blue: 210)
        
    }
    
    @IBAction func didChangeColor(_ sender: UIButton){
        
        color = sender.backgroundColor?.cgColor
        
        for UIButton in myColorButtons {
            if UIButton.isSelected == true {
                UIButton.isSelected = false
                UIButton.layer.borderWidth = 0
                UIButton.layer.cornerRadius = 16
//                UIButton.layer.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y, width: sender.frame.width, height: sender.frame.height)

            }
        }
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            sender.layer.borderColor = UIColor.white.cgColor
            sender.layer.borderWidth = 4
            sender.layer.cornerRadius = 18
//            sender.layer.frame = CGRect(x: (sender.frame.origin.x - 2), y: (sender.frame.origin.y - 2), width: sender.frame.width + 4, height: sender.frame.height + 4)
        }
        
    }
    
    func makeNewSticker() {
        newSticker = UIImageView(image: newlyAddedSticker)
        view.addSubview(newSticker)
        
        let myPanGesture = UIPanGestureRecognizer(target: self, action: #selector(DrawingViewController.handlePan))
        let myPinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(DrawingViewController.handlePinch))
        let myRotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(DrawingViewController.handleRotation))
        let myDoubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(DrawingViewController.handleDoubleTap))
        myPanGesture.delegate = self
        myPinchGesture.delegate = self
        myRotateGesture.delegate = self
        myDoubleTapGesture.numberOfTapsRequired = 2
        myDoubleTapGesture.delegate = self
        newSticker.isUserInteractionEnabled = true
        newSticker.isMultipleTouchEnabled = true
        
        newSticker.addGestureRecognizer(myPanGesture)
        newSticker.addGestureRecognizer(myPinchGesture)
        newSticker.addGestureRecognizer(myRotateGesture)
        newSticker.addGestureRecognizer(myDoubleTapGesture)

    }
    
    @IBAction func didPressSaveButton(_ sender: AnyObject) {
        let myPath = Bundle.main.path(forResource: "beep-brightpop.aif", ofType: nil)
        if let myPath = myPath {
            let url = URL(fileURLWithPath: myPath)
            
            do {
                try myAudioPlayer = AVAudioPlayer(contentsOf: url)
                myAudioPlayer.play()
                UIGraphicsBeginImageContext(view.frame.size)
                view.layer.render(in: UIGraphicsGetCurrentContext()!)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                //Save it to the camera roll
                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                drawImageView.image = nil

            } catch {
                print("Can't play rejected sound")
            }
        } else {
            print("Couldn't find the rejected sound")
        }
    }
    
    @IBAction func didPressTrashButton(_ sender: AnyObject) {
        let myPath = Bundle.main.path(forResource: "beep-rejected.aif", ofType: nil)
        if let myPath = myPath {
            let url = URL(fileURLWithPath: myPath)
            
            do {
                try myAudioPlayer = AVAudioPlayer(contentsOf: url)
                myAudioPlayer.play()
                drawImageView.image = nil
                newSticker.removeFromSuperview()
            } catch {
                print("Can't play rejected sound")
            }
        } else {
            print("Couldn't find the rejected sound")
        }
    }
    
    @nonobjc func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    func handlePan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            newSticker = sender.view as! UIImageView
            newSticker.superview?.bringSubview(toFront: view)
        }else if sender.state == UIGestureRecognizerState.changed {
            newSticker.center = location
        }else if sender.state == UIGestureRecognizerState.ended {
            
        }
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        let myImageView = sender.view as! UIImageView
        myImageView.superview?.bringSubview(toFront: view)

        myImageView.transform = myImageView.transform.scaledBy(x: scale, y: scale)
        sender.scale = 1
        
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer) {
        let myImageView = sender.view as! UIImageView
        myImageView.superview?.bringSubview(toFront: view)
        let rotate = CGAffineTransform(rotationAngle: sender.rotation)
        let scaleAndRotate = rotate.scaledBy(x: 2, y: 2)
        myImageView.transform = scaleAndRotate
        //        let rotate = CGAffineTransform(rotationAngle: sender.rotation)
//        let scaleAndRotate = rotate.scaledBy(x: 3, y: 3)
//        let myImageView = sender.view as! UIImageView
////        myImageView.transform = myImageView.transform.rotated(by: rotation)
//        myImageView.transform = scaleAndRotate
//        sender.rotation = 0
    }
    
    func handleDoubleTap(sender: UITapGestureRecognizer) {
        let myImageView = sender.view as! UIImageView
        myImageView.superview?.bringSubview(toFront: view)
    }
    
    @IBAction func revealDrawer(_ sender: AnyObject) {
        let navVC = splitViewController?.viewControllers[1] as? UINavigationController
        let myStickersVC = navVC?.topViewController as? StickersViewController
        myStickersVC?.willRotate(to: self.interfaceOrientation, duration: 0)
    }

    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
                print("the center of the save button is \(saveButton.center) and the width of the frame is \(grayFrame.frame.width)/r the width of the view is \(self.view.frame.width)")
        
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
        context?.setStrokeColor(color)
        context?.setLineCap(CGLineCap.round)
        context?.setLineJoin(CGLineJoin.round)
        context?.strokePath()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        drawImageView.image = newImage
    }


}

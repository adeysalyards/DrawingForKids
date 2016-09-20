//
//  DrawingViewController.swift
//  DrawingForKids
//
//  Created by Adey Salyards on 8/9/16.
//  Copyright © 2016 Adey Salyards. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
//    var colorStruct = Sticker(displayName:"", image: UIImage(named: "Apple@2x.png")!)
    var start: CGPoint!
    var rgbColor: (CGFloat, CGFloat, CGFloat) = (116/255, 116/255, 116/255)
    @IBOutlet weak var drawImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawImageView.backgroundColor = UIColor(red: 1, green: 245/255, blue: 230/255, alpha: 1)

        navigationItem.title = "My Drawing"
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        start = touch.locationInView(self.drawImageView)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let end = touch.locationInView(self.drawImageView)
        if let s = self.start {
            draw(s, end: end)
        }
        self.start = end
    }
    
    func draw(start: CGPoint, end: CGPoint){
        UIGraphicsBeginImageContext(self.drawImageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        drawImageView?.image?.drawInRect(CGRect(x: 0, y: 0, width: drawImageView.frame.width, height: drawImageView.frame.height))
        
        CGContextSetLineWidth(context, 6)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, start.x, start.y)
        CGContextAddLineToPoint(context, end.x, end.y)
        CGContextSetRGBStrokeColor(context, rgbColor.0, rgbColor.1, rgbColor.2, 1)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineJoin(context, CGLineJoin.Round)
        CGContextStrokePath(context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        drawImageView.image = newImage
    }


}
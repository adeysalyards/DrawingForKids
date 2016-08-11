//
//  DrawingViewController.swift
//  DrawingForKids
//
//  Created by Adey Salyards on 8/9/16.
//  Copyright © 2016 Adey Salyards. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    var colorStruct = Sticker(displayName:"", color: UIColor.blackColor())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundColor = colorStruct.color
        view.backgroundColor = backgroundColor

        navigationItem.title = "My Drawing"
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
        
        //view.backgroundColor = UIColor.purpleColor()
    }

}
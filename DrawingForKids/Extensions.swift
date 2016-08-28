//
//  Extensions.swift
//  DrawingForKids
//
//  Created by Salyards, Adey on 8/26/16.
//  Copyright © 2016 Adey Salyards. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
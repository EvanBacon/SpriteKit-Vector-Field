//
//  UIColor+Bacon.swift
//  Circle
//
//  Created by Evan Bacon on 12/17/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

import UIKit

extension UIColor {
    
    func randomBrightColor() -> UIColor {
        let hue = CGFloat( Double(arc4random()) % 256.0 / 256.0 );  //  0.0 to 1.0
        let saturation = CGFloat( Double(arc4random()) % 128.0 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        let brightness = CGFloat( Double(arc4random()) % 128.0 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}


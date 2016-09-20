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
        let hue = CGFloat( Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 256.0 );  //  0.0 to 1.0
        let saturation = CGFloat( Double(arc4random()).truncatingRemainder(dividingBy: 128.0) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        let brightness = CGFloat( Double(arc4random()).truncatingRemainder(dividingBy: 128.0) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}



public extension UIColor {
    /// The RGBA components associated with a `UIColor` instance.
    var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.cgColor.components!
        
        return (r: components[0], g: components[1], b: components[2], a: components[3])
    }
    
    /**
     Returns a `UIColor` by interpolating between two other `UIColor`s.
     - Parameter fromColor: The `UIColor` to interpolate from
     - Parameter toColor:   The `UIColor` to interpolate to (e.g. when fully interpolated)
     - Parameter progress:  The interpolation progess; must be a `CGFloat` from 0 to 1
     
     - Returns: The interpolated `UIColor` for the given progress point
     */
    static func interpolateFrom(fromColor: UIColor, to toColor: UIColor, withProgress progress: CGFloat) -> UIColor {
        let fromComponents = fromColor.components
        let toComponents = toColor.components
        
        let r = (1 - progress) * fromComponents.r + progress * toComponents.r
        let g = (1 - progress) * fromComponents.g + progress * toComponents.g
        let b = (1 - progress) * fromComponents.b + progress * toComponents.b
        let a = (1 - progress) * fromComponents.a + progress * toComponents.a
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

//
//  UIColor+Extension.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
    
    /// UIColor(rgb: 0xFFFFFF).withAlphaComponent(1.0)
    convenience init(rgb: Int) {
           self.init(
               red: (rgb >> 16) & 0xFF,
               green: (rgb >> 8) & 0xFF,
               blue: rgb & 0xFF
           )
       }

    /// let's suppose alpha is the first component (ARGB)
    /// UIColor(argb: 0xFFFFFFFF)
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}

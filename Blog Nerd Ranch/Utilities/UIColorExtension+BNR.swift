//
//  UIColor.swift
//  WeRISE Conf
//
//  Created by Alecsandra Konson on 11/10/17.
//  Copyright © 2017 wwcodeatl. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let lightestGray = UIColor(hex: 0xEBEBEB)


    // based on tutorial https://www.youtube.com/watch?v=JI7-f3c1eEM
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}

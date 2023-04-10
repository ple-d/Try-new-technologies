//
//  Colors.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import UIKit

enum Colors {
    /// #232323
    static let backgroundGray = UIColor(r: 35, g: 35, b: 35)
    
    /// #5a5a5a
    static let buttonGray = UIColor(r: 90, g: 90, b: 90)
    
    /// #ededed
    static let textWhite = UIColor(r: 237, g: 237, b: 237)
    
    /// #717171
    static let cellGray = UIColor(r: 113, g: 113, b: 113)
    
    static let unusedRed = UIColor(r: 181, g: 74, b: 74)
    
    static let selectedBlue = UIColor(r: 31, g: 53, b: 85)
}

private extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
}

//
//  Fonts.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import UIKit

enum Fonts {
    
    static func printAllFonts() {
        for family in UIFont.familyNames {

            let sName: String = family as String
            print("family: \(sName)")
                    
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }
    
    // MARK: Private
    
    private static let
        montserratRegular = "Montserrat-Regular",
        montserratLight = "Montserrat-ExtraLight",
        montserratBold = "Montserrat-Bold"
    
    
    private static func getFont(name: String, size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

// MARK: Montserrat

extension Fonts {
    
    static func regular(ofSize size: CGFloat) -> UIFont {
        return getFont(name: montserratRegular, size: size)
    }

    static func light(ofSize size: CGFloat) -> UIFont {
        return getFont(name: montserratLight, size: size)
    }
    
    static func bold(ofSize size: CGFloat) -> UIFont {
        return getFont(name: montserratBold, size: size)
    }
}

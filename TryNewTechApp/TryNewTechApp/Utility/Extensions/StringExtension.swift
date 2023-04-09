//
//  StringExtension.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import UIKit

extension String {
    func textSize(font: UIFont, forWidth: CGFloat) -> CGSize {
        return textSize(font: font, forWidth: forWidth, forHeight: .greatestFiniteMagnitude)
    }
    
    func textSize(font: UIFont, forWidth: CGFloat, forHeight: CGFloat) -> CGSize {
        let constrainedSize = CGSize(width: forWidth, height: forHeight)
        let drawingOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading, .truncatesLastVisibleLine]
        
        let str = NSString(string: self)
        let boundingRect = str.boundingRect(with: constrainedSize, options: drawingOptions,
                                            attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingRect.size
    }
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }

    var digitsOnly: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}

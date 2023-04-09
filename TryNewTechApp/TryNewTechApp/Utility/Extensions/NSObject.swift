//
//  NSObject.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation

extension NSObject: DebugLoggable { }

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return String(describing: type(of: self))
    }
}

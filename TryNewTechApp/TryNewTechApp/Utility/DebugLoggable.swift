//
//  DebugLoggable.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation

protocol DebugLoggable {
    func logFunc(funcName: String)
    func logFuncWith(prefix: String, funcName: String)
    func log(_ message: String, funcName: String)
    func logWith(prefix: String, message: String, funcName: String)
    func logThread(funcName: String)
    func logThread(_ message: String, funcName: String)
    
    static func logFunc(funcName: String)
    static func logFuncWith(prefix: String, funcName: String)
    static func log(_ message: String, funcName: String)
    static func logWith(prefix: String, message: String, funcName: String)
    static func logThread(funcName: String)
    static func logThread(_ message: String, funcName: String)
}

extension DebugLoggable {
    
    // MARK: Static
    
    static func logFunc(funcName: String = #function) {
        #if DEBUG
        let className = getClassName()
        print("\(className) \(funcName)")
        #endif
    }
    
    static func logFuncWith(prefix: String, funcName: String = #function) {
        #if DEBUG
        let className = getClassName()
        print("\(prefix). \(className) \(funcName)")
        #endif
    }
    
    static func log(_ message: String, funcName: String = #function) {
        #if DEBUG
        let className = getClassName()
        print("\(className) \(funcName): \(message)")
        #endif
    }
    
    static func logWith(prefix: String, message: String, funcName: String = #function) {
        #if DEBUG
        let className = getClassName()
        print("\(prefix). \(className) \(funcName): \(message)")
        #endif
    }
    
    static func logThread(funcName: String = #function) {
        #if DEBUG
        let className = getClassName()
        let thread = Thread.current.isMainThread ? "main" : "bg"
        print("\(className) \(funcName): \(thread) thread")
        #endif
    }
    
    static func logThread(_ message: String, funcName: String = #function) {
        #if DEBUG
        let className = getClassName()
        let thread = Thread.current.isMainThread ? "main" : "bg"
        print("\(className) \(funcName): \(thread) thread; \(message)")
        #endif
    }
    
    private static func getClassName() -> String {
        return String(describing: self)
    }
    
    // MARK: Non-static
    
    func logFunc(funcName: String = #function) {
        type(of: self).logFunc(funcName: funcName)
    }

    func logFuncWith(prefix: String, funcName: String = #function) {
        type(of: self).logFuncWith(prefix: prefix, funcName: funcName)
    }

    func log(_ message: String, funcName: String = #function) {
        type(of: self).log(message, funcName: funcName)
    }

    func logWith(prefix: String, message: String, funcName: String = #function) {
        type(of: self).logWith(prefix: prefix, message: message, funcName: funcName)
    }
    
    func logThread(funcName: String = #function) {
        type(of: self).logThread(funcName: funcName)
    }
    
    func logThread(_ message: String, funcName: String = #function) {
        type(of: self).logThread(message, funcName: funcName)
    }
}

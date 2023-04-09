//
//  SwiftyUserDefaults.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation
import SwiftyUserDefaults

// swiftlint:disable:next identifier_name
let Defaults = UserDefaults.standard

// Public typealias to avoid importing of SwiftyUserDefaults everywhere
typealias DefaultsKeys = SwiftyUserDefaults.DefaultsKeys

func initDefaults() {
    migrateDefaults()
}

// MARK: Non reset on logout keys
extension DefaultsKeys {
    static let currentBuildVersion = DefaultsKey<String?>("currentBuildVersion")
    static let defaultsVersion = DefaultsKey<Int?>("defaultsVersion")
    
    static let appFirstLaunchDate = DefaultsKey<Date?>("appFirstLaunchDate")
    static let appFirstLaunchVersion = DefaultsKey<String?>("appFirstLaunchVersion")
    static let appFirstLaunchBuild = DefaultsKey<String?>("appFirstLaunchBuild")
}

// MARK: Clear on logout
extension UserDefaults {
    func clearUserData() {
        // Do not reset 'defaultsVersion'
        // Do not reset 'currentBuildVersion'
        
        //Defaults.remove(DefaultsKeys.key)
    }
}

// MARK: Defaults Migrations

private let defaultsVersion = 1

private func migrateDefaults() {
    //let storedVersion = Defaults[DefaultsKeys.defaultsVersion] ?? 0
    // Do any migrations here
    Defaults[DefaultsKeys.defaultsVersion] = defaultsVersion
}

// MARK: Private methods

private extension UserDefaults {
    private func clearWholeUserDefaults() {
        if let bundleId = Bundle.main.bundleIdentifier {
            Defaults.removePersistentDomain(forName: bundleId)
        }
    }
}

//extension Id: DefaultsSerializable {
//    // swiftlint:disable identifier_name
//    public static var _defaults: DefaultsIdBridge { return DefaultsIdBridge() }
//
//    public struct DefaultsIdBridge: DefaultsBridge {
//        init() {}
//
//        public func save(key: String, value: Id?, userDefaults: UserDefaults) {
//            userDefaults.set(value, forKey: key)
//        }
//
//        public func get(key: String, userDefaults: UserDefaults) -> Id? {
//            if let number = userDefaults.object(forKey: key) as? NSNumber {
//                return number.int64Value
//            }
//
//            // Fallback for launch arguments
//            if let string = userDefaults.object(forKey: key) as? String, let int = Id(string) {
//                return int
//            }
//
//            return nil
//        }
//
//        public func deserialize(_ object: Any) -> Id? {
//            return nil
//        }
//    }
//}


//
//  KeychainHelper.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import KeychainAccess

/// Use subscript to get/set values. To remove value set nil.
let Keychain = KeychainAccess.Keychain(service: "ru.dmitriiPleshanov.tryNewTechApp")
// swiftlint:disable:previous identifier_name

enum KeychainKeys {
}

class KeychainKey {
    let key: String
    init(key: String) {
        self.key = key
    }
}

extension Keychain {
    subscript(key: KeychainKey) -> String? {
        get {
            return self[key.key]
        }
        set {
            self[key.key] = newValue
        }
    }
}

// MARK: Certain project keys

extension KeychainKeys {
    static let authData = KeychainKey(key: "authData")
    static let deviceUuid = KeychainKey(key: "deviceUuid")
}


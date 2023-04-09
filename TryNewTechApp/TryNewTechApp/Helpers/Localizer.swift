//
//  Localizer.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation
class Localizer {
    static let shared = Localizer()
    
    static let languageChangeNotificationName = NSNotification.Name(rawValue: "LocalizerLanguageChange")
    
    private let notFoundValue = "<NoString>"
    
    private var bundle: Bundle
    
    private var loadAction: (() -> BundleSupportedLanguage?)?
    private var storeAction: ((BundleSupportedLanguage) -> Void)?
    
    var languageChanged: ((BundleSupportedLanguage) -> Void)?
    
    private init() {
        bundle = Bundle.main
        setLangFromStored()
    }
    
    func setLoaderStorer(loader: @escaping () -> BundleSupportedLanguage?, storer: @escaping (BundleSupportedLanguage) -> Void, loadImmediately: Bool = true) {
        self.loadAction = loader
        self.storeAction = storer
        
        if loadImmediately {
            setLangFromStored()
        }
    }
    
    func getCurrentLanguage() -> BundleSupportedLanguage {
        guard let val = BundleSupportedLanguage(rawValue: Localizations.languageIdentifier) else {
            fatalError("Could not get BundleSupportedLanguage from Localizations")
        }

        return val
    }
    
    func getLocale() -> Locale {
        let lang = getCurrentLanguage()
        let locale = Locale(identifier: lang.rawValue)
        return locale
    }
    
    func getPreferredLanguage() -> BundleSupportedLanguage? {
        // https://developer.apple.com/library/archive/qa/qa1828/_index.html
        //func determineTheLanguageToUse():
        //  for each user's preferredLanguages
        //    if app supports the language
        //      return the language
        //    if app supports a more generic dialect
        //      return the generic language
        //
        //  # Exhausted preferredLanguages and still cannot determine..
        //  return CFBundleDevelopmentRegion
        
        for prefLangId in Locale.preferredLanguages {
            if let lang = BundleSupportedLanguage(rawValue: prefLangId) {
                return lang
            }
        }
        
        return nil
    }
    
    func setLanguage(_ lang: BundleSupportedLanguage) {
        applyLang(lang)
        store(lang: lang)
    }
    
    func resetLanguageToDevice() {
        bundle = Bundle.main
        onLangChanged()
    }
    
    func getLocalizedString(forKey key: String) -> String {
        let localizedStr = bundle.localizedString(forKey: key, value: notFoundValue, table: nil)
        assert(localizedStr != notFoundValue, "Cannot localize key: \(key)")
        return localizedStr
    }
    
    func getPluralLocalizedString(forKey key: String, values: CVarArg...) -> String {
        let localizedStr = getLocalizedString(forKey: key)
        // TODO: - Looks like locale is ignored
        let result = withVaList(values) {
            (NSString(format: localizedStr, locale: getLocale(), arguments: $0) as String)
        }
        return result
    }
    
    private func applyLang(_ lang: BundleSupportedLanguage) {
        guard let path = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj"),
            let bundleWithLang = Bundle(path: path) else {
                assertionFailure("Could not load language bundle: \(lang.rawValue)")
                return
        }
        
        debugPrint("Applying lang: \(lang)")
        
        bundle = bundleWithLang
        
        onLangChanged()
    }
    
    private func onLangChanged() {
        let lang = getCurrentLanguage()
        NotificationCenter.default.post(name: type(of: self).languageChangeNotificationName, object: nil)
        languageChanged?(lang)
    }
    
    private func setLangFromStored() {
        guard let storedLang = getStoredLang() else { return }
        
        applyLang(storedLang)
    }
    
    private func store(lang: BundleSupportedLanguage) {
        storeAction?(lang)
    }
    
    private func getStoredLang() -> BundleSupportedLanguage? {
        return loadAction?()
    }
}

enum BundleSupportedLanguage: String {
    case en
    case ru
}

extension BundleSupportedLanguage: CaseIterable {
}

//extension BundleSupportedLanguage: CustomStringConvertible {
//    var description: String {
//        switch self {
//        case .en:
//            return Localizations.lang.en
//        case .ru:
//            return Localizations.lang.ru
//        }
//    }
//}

// swiftlint:disable:next identifier_name
func LocalizedString(_ key: String, comment: String) -> String {
    return Localizer.shared.getLocalizedString(forKey: key)
}

private func debugPrint(_ message: String) {
    Swift.debugPrint("Localizer: \(message)")
}

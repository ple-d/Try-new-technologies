//
//  Bundle.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation
import UIKit

extension Bundle {
    var releaseVersion: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersion: String? {
        return self.infoDictionary?[kCFBundleVersionKey as String] as? String
    }

    var appIcon: UIImage? {
        guard let appIcons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryAppIcon = appIcons["CFBundlePrimaryIcon"] as? [String: Any],
            let appIconFiles = primaryAppIcon["CFBundleIconFiles"] as? [String] else {
            return nil
        }
        
        guard let appIcon = appIconFiles.last else {
            return nil
        }
        
        return UIImage(named: appIcon)
    }
}

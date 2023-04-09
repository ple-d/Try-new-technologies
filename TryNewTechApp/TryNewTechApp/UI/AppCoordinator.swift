//
//  AppCoordinator.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation
import UIKit

class AppCoordinator: WindowCoordinator {
    static let shared = AppCoordinator()
    
    let networkProvidersFactory: NetworkProvidersFactory

    private var screenshotObserver: NSObjectProtocol?
    
    private override init() {
        networkProvidersFactory = NetworkProvidersFactory()
        
        super.init()
        
        executeOnce()
    }
    
    deinit {
        if let screenshotObserver = screenshotObserver {
            NotificationCenter.default.removeObserver(screenshotObserver)
        }
    }
    
    override func start() {
        super.start()

        observeScreenshots()

        runMainCoordIfNot()
    }
    
    // MARK: runCoord

    private func runMainCoordIfNot() {
        if !(self.rootCoordinator is MainCoordinator) {
            set(rootCoordinator: MainCoordinator(rickNetworkService: networkProvidersFactory.getRickProvider()))
        }
    }
    
    // MARK: Methods
    
    private func observeScreenshots() {
        // Remove old
        if let screenshotObserver = screenshotObserver {
            NotificationCenter.default.removeObserver(screenshotObserver)
        }

        // Create new
        self.screenshotObserver = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in

            let topVisibleVCName = self?.window.rootViewController?.getTopVisibleVC().className ?? ""
        }
    }

    private var isMainVCTop: Bool {
        let topVC = self.window.rootViewController?.getTopVisibleViewController()
        let result = topVC is BaseViewController
        return result
    }
    
    // MARK: Initial configuration
    
    private func executeOnce() {
        initDefaults()

        // DeviceGuid in Keychain
        if Keychain[KeychainKeys.deviceUuid] == nil {
            Keychain[KeychainKeys.deviceUuid] = UUID().uuidString
        }
        
        if let currentBuildVersion = Bundle.main.buildVersion {
            Defaults[DefaultsKeys.currentBuildVersion] = currentBuildVersion
        } else {
            assertionFailure("Could not retrieve build version")
        }
        
        // First launch params
        if Defaults[DefaultsKeys.appFirstLaunchDate] == nil {
            Defaults[DefaultsKeys.appFirstLaunchDate] = Date()
        }
        if Defaults[DefaultsKeys.appFirstLaunchVersion] == nil {
            Defaults[DefaultsKeys.appFirstLaunchVersion] = Bundle.main.releaseVersion
        }
        if Defaults[DefaultsKeys.appFirstLaunchBuild] == nil {
            Defaults[DefaultsKeys.appFirstLaunchBuild] = Bundle.main.buildVersion
        }

        Localizer.shared.setLanguage(.ru)
    }
}

//
//  TopVisibleVCProvidable.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import UIKit

@objc
protocol TopVisibleVCProvidable {
    func getTopVisibleVC() -> UIViewController
}

extension UIViewController: TopVisibleVCProvidable {
    func getTopVisibleVC() -> UIViewController {
        if let presentedVC = self.presentedViewController {
            return presentedVC.getTopVisibleVC()
        }
        
        if self.children.count > 0 {
            print("\(self.className) has children, but does not implement TopVisibleVCProvidable")
        }
        
        return self
    }
}

extension UINavigationController {
    override func getTopVisibleVC() -> UIViewController {
        if let presentedVC = self.presentedViewController {
            return presentedVC.getTopVisibleVC()
        }
        
        if let lastVC = self.viewControllers.last {
            return lastVC.getTopVisibleVC()
        }
        
        return self
    }
}

extension UITabBarController {
    override func getTopVisibleVC() -> UIViewController {
        if let presentedVC = self.presentedViewController {
            return presentedVC.getTopVisibleVC()
        }
        
        if let selectedVC = self.selectedViewController {
            return selectedVC.getTopVisibleVC()
        }
        
        return self
    }
}

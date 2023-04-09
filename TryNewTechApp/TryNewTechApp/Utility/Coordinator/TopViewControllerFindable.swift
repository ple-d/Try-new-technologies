//
//  TopViewControllerFindable.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import UIKit

@objc
protocol TopViewControllerFindable {
    func getTopPresentedViewController() -> UIViewController
    func getTopVisibleViewController() -> UIViewController
}

extension UIViewController: TopViewControllerFindable {
    func getTopPresentedViewController() -> UIViewController {
        if let presentedVc = self.presentedViewController {
            return presentedVc.getTopPresentedViewController()
        }
        return self
    }
    
    /// Returns last presented non alert VC (that can present other VCs). Thus all UIAlertViewControllers will be ignored. This method does not modify anything.
    func getLastPresentedNonAlertVC() -> UIViewController {
        if let presentedVc = self.presentedViewController, !(presentedVc is UIAlertController) {
            return presentedVc.getLastPresentedNonAlertVC()
        }
        return self
    }
    
    func getTopVisibleViewController() -> UIViewController {
        if let presentedVC = self.presentedViewController {
            return presentedVC.getTopVisibleViewController()
        }
        return self
    }
}

// TODO: - Does not work for derived classes!

extension UINavigationController {
    override func getTopVisibleViewController() -> UIViewController {
        let superTopVc = super.getTopVisibleViewController()
        guard superTopVc == self else {
            return superTopVc
        }
        
        if let lastVC = self.viewControllers.last {
            return lastVC.getTopVisibleViewController()
        }
        
        return self
    }
}

extension UITabBarController {
    override func getTopVisibleViewController() -> UIViewController {
        let superTopVc = super.getTopVisibleViewController()
        guard superTopVc == self else {
            return superTopVc
        }
        
        if let selectedVC = self.selectedViewController {
            return selectedVC.getTopVisibleViewController()
        }
        
        return self
    }
}

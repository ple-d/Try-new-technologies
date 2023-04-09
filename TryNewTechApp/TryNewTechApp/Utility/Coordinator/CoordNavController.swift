//
//  CoordNavController.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import UIKit

class CoordNavController: UINavigationController {
    private let delegateProxy = NavControllerDelegateProxy()
    
    var swipeBackEnabled = true
    
    var removedFromViewHierarchy: (() -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.delegateProxy.navigationControllerDidShow = { [weak self] navController, viewController, _ in
            // Swipe back gesture activate/deactivate
            if let gr = navController.interactivePopGestureRecognizer {
                let swipeBackEnabled = self?.swipeBackEnabled ?? true
                if let swipeBackSwitchable = viewController as? SwipeBackSwitchable {
                    gr.isEnabled = swipeBackEnabled && swipeBackSwitchable.swipeBackEnabled
                } else {
                    gr.isEnabled = swipeBackEnabled && navController.viewControllers.count > 1
                }
            }
        }
        super.delegate = delegateProxy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var delegate: UINavigationControllerDelegate? {
        @available(*, message: "In iOS < 13 returns internal ProxyDelegate, due to System calls it often with any transition. If we return userDelegate in pre iOS 13, proxyDelegate will no be called.")
        get {
            if #available(iOS 13, *) {
                return delegateProxy.userDelegate
            } else {
                return delegateProxy
            }
        }
        set {
            delegateProxy.userDelegate = newValue
            // Looks like we do not need this anymore
            // We should reset delegate first
             super.delegate = nil
             super.delegate = delegateProxy
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Should be here, not in init
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let isRemoved = self.presentingViewController == nil && self.parent == nil
        if isRemoved {
            removedFromViewHierarchy?()
        }
    }
}

extension CoordNavController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension CoordNavController: ViewControllerCompletable { }

extension CoordNavController {
    private class NavControllerDelegateProxy: NSObject, UINavigationControllerDelegate {
        // private let proxyPrefix = "CoordNavController delegateProxy"
        weak var userDelegate: UINavigationControllerDelegate?

        var navigationControllerDidShow: ((UINavigationController, UIViewController, Bool) -> Void)?

        override func responds(to aSelector: Selector!) -> Bool {
            let result = super.responds(to: aSelector) || userDelegate?.responds(to: aSelector) == true
            // logWith(prefix: proxyPrefix, message: "aSelector: \(String(describing: aSelector)), result=\(result)")
            return result
        }

        override func forwardingTarget(for aSelector: Selector!) -> Any? {
            if userDelegate?.responds(to: aSelector) == true {
                // logWith(prefix: proxyPrefix, message: "aSelector: \(String(describing: aSelector)), return userDelegate")
                return userDelegate
            } else {
                // logWith(prefix: proxyPrefix, message: "aSelector: \(String(describing: aSelector)), return super")
                return super.forwardingTarget(for: aSelector)
            }
        }

        func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
            // logWith(prefix: proxyPrefix, message: "In proxy method. VC: \(viewController)")
            navigationControllerDidShow?(navigationController, viewController, animated)
            userDelegate?.navigationController?(navigationController, didShow: viewController, animated: animated)
        }
    }
}

//
//  Coordinatable.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import UIKit

protocol Coordinatable: AnyObject, CoordChildManagable, DebugLoggable {
    /// Main VC of Coordinator.
    /// In case of Coordinator the same as firstVC
    /// In case of own NavVC in NavCoord - the NavVC
    /// In case of unowned NavVC of NavCoord - the same as firstVC
    var rootViewController: CoordRootVC { get }
    
    /// The Coordinator should be closed by those who started the Coord. So we pass the request back to it.
    var closeRequest: ((_ animated: Bool, _ completion: ActionVoid?) -> Void)? { get set }
    
    /// Implements logic on start, such as set viewController to stac of NavVC in case of NavCoord
    func start()
    
    /// Calls close for children and call closeRequest
    func close(animated: Bool, completion: ActionVoid?)
    
    /// Calls for all children
    func canBeClosed() -> Bool
    
    // MARK: DeepLink methods
    
    /// Search for the top presented child and call process for it
    func forward(deepLink: DeepLink)
    /// Check if this is the same Coord type as required call accept, otherwise call runFromDeepLink
    func process(deepLink: DeepLink)
    /// Accept params of the DeepLink to the Coordinator, by default call runFromDeepLink
    func accept(deepLink: DeepLink)
}

extension Coordinatable {
    func runByPresent(coordinator coord: Coordinatable, animated: Bool = true) {
        // Get topVC which will present child coord
        let topVC = self.rootViewController.getTopPresentedViewController()
        
        // Configure closing of child coord
        coord.closeRequest = { [weak self, unowned coord] animated, completion in
            // We check if VC has not been dismissed by gesture
            // If we will not check, we can dismiss our topVC from its presentingVC
            
            // Self can be nil if whole coordinator hierarchy is changed
            if topVC.presentedViewController != nil {
                topVC.dismiss(animated: animated, completion: { [weak self] in
                    completion?()
                    self?.logWith(prefix: coordinatorLogPrefix, message: "Dismissed")
                })
            }
            // Only for validation
            self?.remove(presentedChild: coord)
        }
        
        // Start working of child coord (before show)
        coord.start()
        
        // Actually present
        topVC.present(coord.rootViewController, animated: animated, completion: nil)
        
        // Register completion
        var rootViewController = coord.rootViewController
        rootViewController.removedFromViewHierarchy = { [weak coord] in
            coord?.close(animated: false, completion: nil)
        }
        
        // Add configured child coord to list
        self.set(presentedChild: coord)
    }
    
    func presentAndGetPresenter(_ vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> UIViewController? {
        guard !hasPresentedChild else {
            assertionFailure("Should not have any children to present")
            return nil
        }
        
        let topVC = self.rootViewController.getTopPresentedViewController()
        
        guard !(topVC is UIAlertController) else {
            assertionFailure("Trying to present from alert")
            return nil
        }
        
        topVC.present(vc, animated: animated, completion: completion)
        
        return topVC
    }
}

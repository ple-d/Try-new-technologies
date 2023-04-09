//
//  NavBaseCoordinator.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation

class NavBaseCoordinator: BaseCoordinator {
    let navController: CoordNavController
    private(set) var hasOwnNavController: Bool
    
    // TODO: - Make generic
    init(navController unownedNC: CoordNavController? = nil, hasOwnNavController: Bool? = nil) {
        if let unownedNC = unownedNC {
            self.navController = unownedNC
            self.hasOwnNavController = hasOwnNavController ?? false
        } else {
            self.navController = CoordNavController()
            self.hasOwnNavController = hasOwnNavController ?? true
        }
        
        super.init()
    }
    
    init(navController unownedNC: CoordNavController? = nil) {
        if let unownedNC = unownedNC {
            self.navController = unownedNC
            self.hasOwnNavController = false
        } else {
            self.navController = CoordNavController()
            self.hasOwnNavController = true
        }
        
        super.init()
    }
    
    override func close(animated: Bool, completion: ActionVoid? = nil) {
        // In case of unowned NavController, after coord close we should rollback stack,
        // so we hide all presented first
        // If we have smth presented, we dismiss it first, then we call closeRequest

        if !hasOwnNavController, navController.presentedViewController != nil {
            navController.dismiss(animated: false) {
                super.close(animated: animated, completion: completion)
            }
        } else {
            super.close(animated: animated, completion: completion)
        }
    }
    
    func runByPush(coordinator coord: NavCoordinator, animated: Bool = true) {
        // NavigationController to which new coord will be pushed
        let navController = coord.navController
        
        guard !coord.hasOwnNavController else {
            logWith(prefix: coordinatorLogPrefix, message: "Cannot push coordinator with its own navigation controller")
            return
        }
        
        // Ensure this Nav did not present any other VC
        guard navController.presentedViewController == nil else {
            logWith(prefix: coordinatorLogPrefix, message: "Root navController has presented view controllers")
            return
        }
        
        // Store topVC of navController
        guard let topVC = navController.viewControllers.last else {
            logWith(prefix: coordinatorLogPrefix, message: "Current coordinator has empty stack in navController")
            return
        }
        
        coord.closeRequest = { [weak self, unowned coord] animated, completion in
            _ = navController.popToViewController(topVC, animated: animated)
            
            // Self can be nil if whole coordinator hierarchy is changed
            self?.remove(internalChild: coord)
            
            DispatchQueue.main.async {
                completion?()
            }
        }
        
        // Start working of child coord (before show)
        coord.start()
        
        // Actual show
        navController.pushViewController(coord.rootViewController, animated: animated)
        
        // Register completion
        var removable = coord.rootViewController
        removable.removedFromViewHierarchy = { [weak coord] in
            coord?.close(animated: false)
        }
        
        // Add configured child coord to list
        self.add(internalChild: coord)
    }
}

extension Coordinatable where Self: NavBaseCoordinator & CoordFirstVCProvidable & CoordStartable {
    var rootViewController: CoordRootVC {
        if self.hasOwnNavController {
            return self.navController
        } else {
            return self.firstViewController
        }
    }

    func start() {
        if self.hasOwnNavController {
            self.navController.setViewControllers([self.firstViewController], animated: true)
        }
        onStart()
    }
}

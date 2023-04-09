//
//  DeepLinks.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

extension Coordinatable {
    /// Forwards DeepLink by the Coord hierarchy to the topmost presented Coord
    func forward(deepLink: DeepLink) {
        if let presentedChild = presentedChild {
            logWith(prefix: coordinatorLogPrefix, message: "Forwarding to presentedChild")
            presentedChild.forward(deepLink: deepLink)
        } else {
            if let lastContained = self.containedChildren.last {
                logWith(prefix: coordinatorLogPrefix, message: "Forwarding to containedChild")
                lastContained.forward(deepLink: deepLink)
            } else {
                logWith(prefix: coordinatorLogPrefix, message: "Processing")
                process(deepLink: deepLink)
            }
        }
    }
    
    /// Determines whether the certain Coord is of the same type as the DeepLink and accepts DeepLink or runs the new Coord otherwise
    func process(deepLink: DeepLink) {
        if deepLink.getCoordType() == type(of: self) {
            logWith(prefix: coordinatorLogPrefix, message: "Accepting")
            accept(deepLink: deepLink)
        } else {
            logWith(prefix: coordinatorLogPrefix, message: "Running new")
            run(fromDeepLink: deepLink)
        }
    }
    
    /// Here params of the deeplink should be accepted. By default runs the new Coord
    func accept(deepLink: DeepLink) {
        logWith(prefix: coordinatorLogPrefix, message: "Running new")
        // Should be implemented by Certain Coordinator
        // By default it starts new Coordinator
        run(fromDeepLink: deepLink)
    }
    
    /// Creates the new Coord and runs it
    func run(fromDeepLink deepLink: DeepLink, animated: Bool = true) {
        logWith(prefix: coordinatorLogPrefix, message: "Run (\(deepLink))")
        let coordType = deepLink.getCoordType()
        
        // Get coordinator to present
        guard let coord = coordType.getCoordinator(deepLink: deepLink) else {
            assertionFailure("Could not retrieve a coordinator")
            return
        }
        
        // Hide all alerts
        let vcAbleToPresent = self.rootViewController.getLastPresentedNonAlertVC()
        if vcAbleToPresent.presentedViewController != nil {
            vcAbleToPresent.dismiss(animated: false) {
                self.runByPresent(coordinator: coord, animated: animated)
            }
        } else {
            runByPresent(coordinator: coord, animated: animated)
        }
    }
}
/// Should be adopted by Coordinators that can be launched with DeepLink
protocol DeepLinkStartable {
    /// Should return coordinator if this type of deeplink can be handled
    static func getCoordinator(deepLink: DeepLink) -> Coordinatable?
}

/// DeepLink should adopt this protocol. Returns type of instance that can process certain deeplink.
protocol DeepLinkable {
    func getCoordType() -> DeepLinkStartable.Type
}

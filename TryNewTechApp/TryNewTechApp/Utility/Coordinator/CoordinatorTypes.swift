//
//  CoordinatorTypes.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import UIKit

let coordinatorLogPrefix = "Coord"

/// Should be adopted by VCs that can report that they are complete (removed from view hierarchy)
protocol ViewControllerCompletable {
    var removedFromViewHierarchy: (() -> Void)? { get set }
}

typealias CoordRootVC = UIViewController & ViewControllerCompletable

protocol CoordFirstVCProvidable {
    /// The Main VC of the Coordinator.
    var firstViewController: CoordRootVC { get }
}

protocol CoordStartable {
    /// Implement here any additional logic that should be executed at coordinator start
    func onStart()
}

typealias Coordinator = BaseCoordinator & Coordinatable & CoordFirstVCProvidable & CoordStartable
typealias NavCoordinator = NavBaseCoordinator & Coordinatable & CoordFirstVCProvidable & CoordStartable

typealias NavAction<Type> = (Type) -> Void

/// Should be adpoted by VCs that can navigate  to another VC or Coordinator
protocol Navigatable {
    associatedtype NavigationType
    var navAction: NavAction<NavigationType>? { get set }
    func navigate(to navigationType: NavigationType)
}

extension Navigatable {
    func navigate(to navigationType: NavigationType) {
        navAction?(navigationType)
    }
}


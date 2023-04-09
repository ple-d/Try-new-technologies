//
//  BaseCoordinator.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation
import UIKit

class BaseCoordinator: NSObject {
    private(set) var presentedChild: Coordinatable?
    private(set) var containedChildren: [Coordinatable] = []
    
    override init() {
        super.init()
        logFuncWith(prefix: coordinatorLogPrefix)
    }
    
    deinit {
        logFuncWith(prefix: coordinatorLogPrefix)
    }
    
    // MARK: Close
    
    var closeRequest: ((_ animated: Bool, _ completion: ActionVoid?) -> Void)?
    
    func close(animated: Bool, completion: ActionVoid? = nil) {
        containedChildren.forEach { $0.close(animated: animated, completion: nil) }
        self.closeRequest?(animated, completion)
    }
    
    func canBeClosed() -> Bool {
        if self.presentedChild?.canBeClosed() == false {
            return false
        }
        
        for child in containedChildren {
            if !child.canBeClosed() {
                return false
            }
        }
        
        return true
    }
    
    func areChildrenCanBeClosed() -> Bool {
        var childrenCanBeClosed = presentedChild?.canBeClosed() ?? true
        
        for containerChild in containedChildren {
            let canBeClosed = containerChild.canBeClosed()
            if !canBeClosed {
                childrenCanBeClosed = canBeClosed
                break
            }
        }
        
        return childrenCanBeClosed
    }
    
    // MARK: Presented child
    
    var hasPresentedChild: Bool {
        self.presentedChild != nil
    }
    
    func set(presentedChild: Coordinatable) {
        guard self.presentedChild == nil else {
            assertionFailure("Already has presented child")
            return
        }
        self.presentedChild = presentedChild
    }
    
    func remove(presentedChild: Coordinatable) {
        assert(self.presentedChild === presentedChild, "Trying to remove another presented child")
        self.presentedChild = nil
    }
    
//    func removePresentedChild() {
//        self.presentedChild = nil
//    }
        
    func add(internalChild item: Coordinatable) {
        // Add only unique object
        for element in containedChildren where element === item {
            logWith(prefix: coordinatorLogPrefix, message: "Cannot add child. Exists already: \(item)")
            return
        }
        containedChildren.append(item)
    }
        
    func remove(internalChild item: Coordinatable) {
        var removed = false
        for (index, element) in containedChildren.enumerated() where element === item {
            containedChildren.remove(at: index)
            removed = true
            break
        }
        
        if !removed {
            logWith(prefix: coordinatorLogPrefix, message: "Cannot remove child. Not found: \(item)")
        }
    }
    
//    func clearChildren() {
//        children = []
//    }
}

extension Coordinatable where Self: BaseCoordinator & CoordFirstVCProvidable & CoordStartable {
    var rootViewController: CoordRootVC {
        firstViewController
    }
    
    func start() {
        onStart()
    }
}

extension BaseCoordinator: CoordChildManagable { }


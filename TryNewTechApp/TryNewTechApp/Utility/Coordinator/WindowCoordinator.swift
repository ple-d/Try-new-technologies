//
//  WindowCoordinator.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import UIKit

class WindowCoordinator: NSObject {
    var window: UIWindow
    
    private(set) var rootCoordinator: Coordinatable?
    
    override init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        super.init()
    }
    
    func start() {
        window.makeKeyAndVisible()
    }
    
    func set(rootCoordinator coord: Coordinatable) {
        self.rootCoordinator = coord
        coord.start()
        window.rootViewController = coord.rootViewController
    }
}


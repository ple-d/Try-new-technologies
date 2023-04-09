//
//  SwipeBackSwitchable.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation

protocol SwipeBackSwitchable {
    /// Called on ViewController (if VC implements) on show
    var swipeBackEnabled: Bool { get }
}

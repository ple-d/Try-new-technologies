//
//  Constants.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import UIKit

enum Constants {
    static let
    highlightedAlpha: CGFloat = 0.2,
    disabledAlpha: CGFloat = 0.5,
    
    stateChangeAnimDuration = 0.2,
    fadeAnimation = 0.3,
    
    sideOffset: CGFloat = Constants.isNarrowScreen ? 15 : 22,
    alertSideOffset: CGFloat = Constants.isNarrowScreen ? 32 : 50,

    dummy = 1

    static let lineThickness: CGFloat = 1.0// / UIScreen.main.scale
    
    static var isNarrowScreen: Bool {
        return UIScreen.main.bounds.width < 375
    }
}

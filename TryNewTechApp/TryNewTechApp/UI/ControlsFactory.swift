//
//  ControlsFactory.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import UIKit

let controlsFactory = ControlsFactory.shared

class ControlsFactory {
    static let shared = ControlsFactory()
    
    func standartButton(withTitle title: String) -> StandartButton {
        let button = StandartButton(frame: .zero)
        button.text = title
        return button
    }
}

//
//  StandartWhiteLabel.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import UIKit

class StandartWhiteLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        textColor = Colors.textWhite
        font = Fonts.regular(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

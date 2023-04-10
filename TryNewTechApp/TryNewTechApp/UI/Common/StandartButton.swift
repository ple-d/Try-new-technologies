//
//  StandartButton.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import UIKit

class StandartButton: UIButton {
    
    var text: String? {
        get {
            titleLabel?.text
        }
        set {
            self.setTitle(newValue, for: .normal)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: Constants.stateChangeAnimDuration, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.backgroundColor = self.isHighlighted ? Colors.selectedBlue : Colors.buttonGray
                self.transform = self.isHighlighted ? CGAffineTransform(translationX: 0, y: 1) : CGAffineTransform.identity
            }, completion: nil)

        }
    }
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = isEnabled ? Colors.buttonGray : Colors.unusedRed
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = .lightGray
        self.backgroundColor = Colors.buttonGray
        self.titleLabel?.textColor = Colors.textWhite
        self.titleLabel?.font = Fonts.bold(ofSize: 21)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

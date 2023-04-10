//
//  RickCollectionHeaderView.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import SnapKit

import RxCocoa

class RickCollectionHeaderView: UICollectionReusableView {
    
    let button: StandartButton = controlsFactory.standartButton(withTitle: Localizations.rick.history)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.edges.equalToSuperview()
        }
    }
    
    var itemClick: Signal<Void> {
        self.button.rx.controlEvent(.touchUpInside).asSignal()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isEnabled: Bool {
        get {
            self.button.isEnabled
        }
        set {
            self.button.isEnabled = newValue
        }
    }
}

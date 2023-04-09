//
//  RickMainContentView.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import SnapKit

class RickMainContentView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-50) / 2, height: (129))
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(RickCollectionViewCell.self, forCellWithReuseIdentifier: RickCollectionViewCell.className)
        view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

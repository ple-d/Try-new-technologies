//
//  RickMainContentView.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import SnapKit

class RickMainContentView: UIView {
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-50), height: 130)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 56)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(RickCollectionViewCell.self, forCellWithReuseIdentifier: RickCollectionViewCell.className)
        view.register(RickCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RickCollectionHeaderView.className)
        view.backgroundColor = Colors.backgroundGray
        view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.backgroundGray
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

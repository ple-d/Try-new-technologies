//
//  RickCollectionViewCell.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import SnapKit
import SDWebImage

class RickCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var nameLabel = StandartWhiteLabel()
    
    private lazy var speciesLabel = StandartWhiteLabel()
    
    private lazy var statusLabel = StandartWhiteLabel()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, speciesLabel, statusLabel])
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .leading
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.cellGray
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubview(imageView)
        addSubview(stackView)
        
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(imageView.snp.height)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.lessThanOrEqualToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: String, name: String, species: String, status: String) {
        self.imageView.sd_setImage(with: URL(string: image))
        self.nameLabel.text = name
        self.speciesLabel.text = species
        self.statusLabel.text = status
    }
    
}

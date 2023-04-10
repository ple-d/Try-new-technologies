//
//  RickMainViewController.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import Moya
import RxSwift
import RxCocoa
import RxSwiftExt
import RxDataSources

final class RickMainViewController: BaseViewController {
    
    var navAction: NavAction<NavType>?
    
    private let viewModel: RickMainViewModel
    
    // MARK: - UI properties
    
    private lazy var contentView: RickMainContentView = {
        let view = RickMainContentView()
        
        return view
    }()
    
    // MARK: - Initialization
    
    init(rickProvider: MoyaProvider<RickNetworkService>) {
        self.viewModel = RickMainViewModel(provider: rickProvider)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        let output = viewModel.output
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, CharacterModel>>.init { ds, collectionView, index, element in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RickCollectionViewCell.className, for: index) as! RickCollectionViewCell
            cell.set(image: element.imageAdress, name: element.name, species: element.species, status: element.status)
            return cell
        } configureSupplementaryView: { ds, collectionView, kind, index in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RickCollectionHeaderView.className, for: index) as! RickCollectionHeaderView
            header.isEnabled = false
            header.itemClick.emit(to: self.viewModel.input.historyClicked).disposed(by: self.disposeBag)
            return header
        }
        
        disposeBag.insert(
            self.rx.viewWillAppear
                .map { _ in () }
                .bind(to: self.viewModel.input.refresher),
            
            self.contentView.collectionView.rx.reachedBottom().bind(to: self.viewModel.input.refresher),
            
            output.characters.map({ models -> [SectionModel<String, CharacterModel>] in
                return [SectionModel(model: "", items: models)]
            }).drive(self.contentView.collectionView.rx.items(dataSource: dataSource))
        )
    }
    
}

extension RickMainViewController: Navigatable {
    enum NavType {
        case detail
        case history
    }
}

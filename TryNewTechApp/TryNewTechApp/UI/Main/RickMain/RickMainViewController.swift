//
//  RickMainViewController.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import Moya

final class RickMainViewController: BaseViewController {
    private let rickProvider: MoyaProvider<RickNetworkService>
    
    var navAction: NavAction<NavType>?
    
    // MARK: - UI properties
    
    private lazy var contentView: RickMainContentView = {
        let view = RickMainContentView()
        
        return view
    }()
    
    // MARK: - Initialization
    
    init(rickProvider: MoyaProvider<RickNetworkService>) {
        self.rickProvider = rickProvider
        super.init()
        
        setupUI()
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
        
    }
    
}

extension RickMainViewController: Navigatable {
    enum NavType {
        case close
        case logout
    }
}

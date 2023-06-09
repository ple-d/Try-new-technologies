//
//  MainCoordinator.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import UIKit
import Moya

class MainCoordinator: Coordinator, DeepLinkStartable {
    
    static func getCoordinator(deepLink: DeepLink) -> Coordinatable? {
        return MainCoordinator(rickNetworkService: NetworkProvidersFactory.shared.getRickProvider())
    }
    
    private var rickNetworkProvider: MoyaProvider<RickNetworkService> {
        AppCoordinator.shared.networkProvidersFactory.getRickProvider()
    }

    private lazy var testVC: BaseViewController = {
        let vc = BaseViewController()
        vc.view.backgroundColor = UIColor.green
        return vc
    }()
    
    private weak var mainNavVC: UINavigationController?
    
    private lazy var mainVC: RickMainViewController = {
        let vc = RickMainViewController(rickProvider: rickNetworkProvider)
        return vc
    }()
    
    var firstViewController: UIViewController & ViewControllerCompletable {
        mainVC
    }

    init(rickNetworkService: MoyaProvider<RickNetworkService>) {
        super.init()
    }

    func onStart() {
    }
    
}

//
//  RIckMainViewModel.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

import RxSwift
import RxCocoa
import Moya

class RickMainViewModel: StoringViewModellable {
    
    let input: Input
    let output: Output
    
    let provider: MoyaProvider<RickNetworkService>
    private let disposeBag = DisposeBag()
    
    struct Input {
        
    }

    struct Output {
        var preparedNavigationAction = PublishRelay<RickMainViewController.NavType>()
    }
    
    init(provider: MoyaProvider<RickNetworkService>) {
        self.provider = provider
        self.input = Input()
        self.output = Output()
    }
}

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
    
    private var page = 0
    private var maxValue = 20
    
    private let charactersResponse = PublishRelay<PaginatedCharactersResponse?>()
    private let charactersRelay = BehaviorRelay<[CharacterModel]>(value: [])
    
    struct Input {
        var refresher = PublishRelay<Void>()
        var itemSelected = PublishRelay<CharacterModel>()
        var historyClicked = PublishRelay<Void>()
    }

    struct Output {
        var characters: Driver<[CharacterModel]>
        
        var preparedNavigationAction = PublishRelay<RickMainViewController.NavType>()
    }
    
    init(provider: MoyaProvider<RickNetworkService>) {
        self.provider = provider
        
        self.input = Input()
        self.output = Output(characters: charactersRelay.asDriver())
        
        bind()
    }
    
    private func bind() {
    
        let charactersOrdersRequest = self.input.refresher.flatMapLatest { () -> Observable<Event<PaginatedCharactersResponse>> in
            
            return self.provider.rx
                .request(.character(page: self.page))
                .parseObject(PaginatedCharactersResponse.self)
                .asObservable()
                .materialize()
        }.share()
        
        charactersOrdersRequest
            .compactMap({ $0.element })
            .bind(to: charactersResponse)
            .disposed(by: disposeBag)
        
        charactersResponse.bind { [weak self] response in
            guard let response, let self else { return }
            self.page += 1
            var newValue = self.charactersRelay.value
            newValue.append(contentsOf: (response.results))
            self.charactersRelay.accept(newValue)
        }.disposed(by: disposeBag)
    }
}

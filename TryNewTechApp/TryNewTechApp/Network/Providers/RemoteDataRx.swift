//
//  RemoteDataRx.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import RxCocoa
import RxSwift

class RemoteDataRx<DataType> {
    let refresher = PublishRelay<Void>()
    private let dataVar = BehaviorRelay<DataType?>(value: nil)
    private let errorVar = BehaviorRelay<Error?>(value: nil)
    private let loadingVar = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()

    var data: Driver<DataType?> {
        return dataVar.asDriver()
    }

    var error: Driver<Error?> {
        return errorVar.asDriver()
    }

    var loading: Driver<Bool> {
        return loadingVar.asDriver()
    }

    init(remoteRequest: @escaping () -> Single<DataType>) {
        let request = refresher
            .flatMapLatest { () -> Observable<Event<DataType>> in
                return remoteRequest().asObservable().materialize()
            }
            .share()
        
        request
            .compactMap({ $0.element })
            .bind(to: dataVar)
            .disposed(by: disposeBag)
        
        request
            .filter({ !$0.isCompleted })
            .map({ $0.error })
            .bind(to: errorVar)
            .disposed(by: disposeBag)
        
        Observable<Bool>
            .merge(refresher.map { _ in true }, request.map { _ in false })
            .bind(to: loadingVar)
            .disposed(by: disposeBag)
    }
    
    func reload() {
        refresher.accept(())
    }
    
    func clear() {
        dataVar.accept(nil)
        errorVar.accept(nil)
        loadingVar.accept(false)
    }
}

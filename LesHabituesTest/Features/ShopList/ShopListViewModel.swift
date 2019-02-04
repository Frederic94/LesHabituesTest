//
//  ShopListViewModel.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow

final class ShopListViewModel: ViewModelType, Stepper {
    typealias ShopSectionModel = SectionModel<String, ShopViewModel>

    enum State {
        case loading
        case loaded
        case error
    }

    struct Input {
        var refresh: AnyObserver<Void>
    }

    struct Output {
        var sections: Observable<[ShopSectionModel]>
        var state: Driver<State>
    }

    // MARK: Private
    private let dataController: ShopDataController!
    private let sectionsSubject = ReplaySubject<[ShopSectionModel]>.create(bufferSize: 1)
    private let stateSubject = BehaviorSubject<State>(value: .loading)
    private let refreshSubject = PublishSubject<Void>()

    // MARK: Public
    let input: Input
    let output: Output

    init() {
        self.dataController = ShopDataController()
        self.input = Input(refresh: refreshSubject.asObserver())
        self.output = Output(sections: sectionsSubject.asObservable(),
                             state: stateSubject.asDriver(onErrorJustReturn: .error))

        setup()
    }
}

// MARK: Setup & Binding
private extension ShopListViewModel {
    func setup() {
        callWs()
        setupRefresh()
    }

    func callWs() {
        let responseShare = dataController.getShops()
                        .asObservable()
                        .share()

        responseShare
            .flatMap { result -> Single<[Shop]> in
                switch result {
                case .success(let response):
                    return .just(response.results)
                case .failure:
                    return .never()
                }
            }.map { shops -> [ShopViewModel] in
                shops.map { ShopViewModel(shop: $0) }
            }.map { vms -> [ShopSectionModel] in
                return [ShopSectionModel(model: "", items: vms)]
            }.bind(to: sectionsSubject)
            .disposed(by: disposeBag)

        responseShare
            .flatMap { result -> Single<State> in
                switch result {
                case .success:
                    return .just(State.loaded)
                case .failure:
                    return .just(State.error)
                }
            }.bind(to: stateSubject)
            .disposed(by: disposeBag)
    }

    func setupRefresh() {
        refreshSubject
            .subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.callWs()
        }).disposed(by: disposeBag)
    }
}

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
    typealias ShopSectionModel = SectionModel<String, SignShopModel>

    enum State {
        case loading
        case loaded
        case error
    }

    struct Input {
        var refresh: AnyObserver<Void>
        var selected: AnyObserver<SignShopModel>
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
    private let selectedSubject = PublishSubject<SignShopModel>()

    // MARK: Public
    let input: Input
    let output: Output

    init(dataController: ShopDataController) {
        self.dataController = dataController
        self.input = Input(refresh: refreshSubject.asObserver(),
                           selected: selectedSubject.asObserver())
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
        setupSelected()
    }

    func callWs() {
        let responseShare = dataController.getShops()
                        .share()

        responseShare
            .flatMap { result -> Single<[SignShopResponse]> in
                switch result {
                case .success(let response):
                    return .just(response)
                case .failure(let error):
                    print(error)
                    return .never()
                }
            }.map { shops -> [SignShopModel] in
                shops.map { SignShopModel(shop: $0) }
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
    
    func setupSelected() {
        selectedSubject
            .map { signShop -> Step in
                return AppStep.signShopDetail(signShop.getId())
            }.bind(to: step)
            .disposed(by: disposeBag)
    }
}

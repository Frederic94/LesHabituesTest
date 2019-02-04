//
//  ShopListViewModel.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import RxFlow

final class ShopListViewModel: ViewModelType, Stepper {
    typealias ShopSectionModel = SectionModel<String, ShopViewModel>


    struct Input {

    }

    struct Output {
        var sections: Observable<[ShopSectionModel]>
    }

    // MARK: Private
    private let dataController: ShopDataController!
    private let sectionsSubject = ReplaySubject<[ShopSectionModel]>.create(bufferSize: 1)

    // MARK: Public
    let input: Input
    let output: Output

    init() {
        self.dataController = ShopDataController()
        self.input = Input()
        self.output = Output(sections: sectionsSubject.asObservable())

        setup()
    }
}

// MARK: Setup & Binding
private extension ShopListViewModel {
    func setup() {
        callWs()
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
    }
}

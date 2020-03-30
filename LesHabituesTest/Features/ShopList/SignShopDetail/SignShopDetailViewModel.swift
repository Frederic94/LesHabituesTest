//
//  SignShopDetailViewModel.swift
//  LesHabituesTest
//
//  Created by Frédéric Mallet on 30/03/2020.
//  Copyright © 2020 Frederic Mallet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow

final class SignShopDetailViewModel: ViewModelType, Stepper {
    typealias DetailSectionModel = SectionModel<String, ShopModel>

    struct Input {
    }

    struct Output {
        var title: Driver<String>
        var sections: Observable<[DetailSectionModel]>
    }

    // MARK: Private
    private let signShop: SignShopResponse
    private let sectionsSubject = ReplaySubject<[DetailSectionModel]>.create(bufferSize: 1)

    // MARK: Public
    let input: Input
    let output: Output

    init(signShop: SignShopResponse) {
        self.signShop = signShop
        self.input = Input()
        self.output = Output(title: .just(signShop.chain),
                             sections: sectionsSubject.asObservable())

        setup()
    }
}

// MARK: Setup & Binding
private extension SignShopDetailViewModel {
    func setup() {
        Observable.just(signShop)
            .map { $0.localisations.map { ShopModel(shop: $0) } }
            .map { [DetailSectionModel(model: "", items: $0)]}
            .bind(to: sectionsSubject)
            .disposed(by: disposeBag)
    }
}

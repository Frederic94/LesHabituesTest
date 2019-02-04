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

    }

    // MARK: Public
    let input: Input
    let output: Output

    init() {
        self.input = Input()
        self.output = Output()
    }
}

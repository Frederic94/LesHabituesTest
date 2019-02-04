//
//  AppFlow.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import UIKit
import RxFlow

final class AppFlow: Flow {

    var root: Presentable {
        return self.rootWindow
    }

    private let rootWindow: UIWindow

    init(withWindow window: UIWindow) {
        self.rootWindow = window
    }

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return NextFlowItems.none }

        switch step {
        case .shopList:
            return navigateToShopList()
        default:
            return NextFlowItems.none
        }
    }

    private func navigateToShopList() -> NextFlowItems {
        return .none
    }
}

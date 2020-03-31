//
//  ShopFlow.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import RxFlow

final class ShopFlow: Flow {

    var root: Presentable {
        return rootViewController
    }
    private let rootViewController = UINavigationController()

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else {return .none}
        switch step {
        case .shopList:
            return navigateToShopList()
        case .signShopDetail(let id):
            return navigateToShopDetail(signShopId: id)
        }
    }

    private func navigateToShopList() -> NextFlowItems {
        let vm = ShopListViewModel(dataController: ShopDataController())
        let root = ShopListViewController.instantiate()
        root.viewModel = vm
        rootViewController.pushViewController(root, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: root,
                                           nextStepper: root.viewModel))
    }
    
    private func navigateToShopDetail(signShopId: Int) -> NextFlowItems {
        let vm = SignShopDetailViewModel(dataController: ShopDataController(),
                                         signShopId: signShopId)
        let root = SignShopDetailViewController.instantiate()
        root.viewModel = vm
        rootViewController.pushViewController(root, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: root,
                                           nextStepper: root.viewModel))
    }
}

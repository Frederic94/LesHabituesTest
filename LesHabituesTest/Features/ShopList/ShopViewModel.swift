//
//  ShopViewModel.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import UIKit

struct SignShopModel {
    private let shop: SignShopResponse

    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()


    lazy var logo: URL? = {
        return URL(string: shop.logo)
    }()

    lazy var name: String = {
        return shop.chain.uppercased()
    }()

    lazy var category: String = {
        return shop.categoryName
    }()

    init(shop: SignShopResponse) {
        self.shop = shop
    }
}

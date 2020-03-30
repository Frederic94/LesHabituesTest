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
    
    func getResponse() -> SignShopResponse {
        return shop
    }
}


struct ShopModel {
    private let shop: ShopResponse

    lazy var name: String = {
        return shop.name.uppercased()
    }()

    lazy var adress: String = {
        return "\(shop.address)\n\(shop.zipcode) \(shop.city)"

    }()

    init(shop: ShopResponse) {
        self.shop = shop
    }
}

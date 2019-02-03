//
//  Shop.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 03/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation

public struct ShopListResponse: Decodable {
    public var object: String
    public var total: Int
    public var results: [Shop]
}

public struct Shop: Decodable {

    public var id: Int
    public var shopId: Int
    public var latitude: String
    public var longitude: String
    public var distance: String
    public var name: String
    public var chain: String
    public var address: String
    public var zipcode: String
    public var city: String
    public var categoryId: Int
    public var categoryName: String
    public var logo: String
    public var cover: String
    public var maxoffer: String
    public var currency: String

    enum CodingKeys: String, CodingKey {
        case id
        case shopId = "shop_id"
        case latitude
        case longitude
        case distance
        case name
        case chain
        case address
        case zipcode
        case city
        case categoryId = "category_id"
        case categoryName = "category_name"
        case logo
        case cover
        case maxoffer
        case currency
    }
}

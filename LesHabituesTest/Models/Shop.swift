//
//  Shop.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 03/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation

public struct SignShopListResponse: Decodable {
    public var object: String
    public var total: Int
    public var data: [SignShopResponse]
}

public struct SignShopResponse: Decodable {
    public var id: Int
    public var chain: String
    public var categoryId: Int
    public var categoryName: String
    public var logo: String
    public var localisations: [ShopResponse]

    enum CodingKeys: String, CodingKey {
        case id
        case chain
        case categoryId = "category_id"
        case categoryName = "category"
        case logo = "picture_url"
        case localisations
    }
}

extension SignShopResponse {
    func toDB() -> SignShopDB {
        let signShopDB = SignShopDB()
        signShopDB.id = self.id
        signShopDB.chain = self.chain
        signShopDB.categoryId = self.categoryId
        signShopDB.categoryName = self.categoryName
        signShopDB.logo = self.logo
        signShopDB.localisations.append(objectsIn: self.localisations.map { $0.toDB() })
        return signShopDB
    }
}

public struct ShopResponse: Decodable {
    public var id: Int
    public var name: String
    public var address: String
    public var zipcode: String
    public var city: String
}

extension ShopResponse {
    func toDB() -> ShopDB {
        let shopDB = ShopDB()
        shopDB.id = self.id
        shopDB.name = self.name
        shopDB.address = self.address
        shopDB.zipcode = self.zipcode
        shopDB.city = self.city
        return shopDB
    }
}

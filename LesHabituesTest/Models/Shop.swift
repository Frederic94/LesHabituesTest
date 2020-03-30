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

public struct ShopResponse: Decodable {
    public var id: Int
    public var name: String
    public var address: String
    public var zipcode: String
    public var city: String
    public var geoloc: ShopGeolocResponse
}

public struct ShopGeolocResponse: Decodable {
    public var latitude: Double
    public var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

//
//  SignShopDB.swift
//  LesHabituesTest
//
//  Created by Frédéric Mallet on 30/03/2020.
//  Copyright © 2020 Frederic Mallet. All rights reserved.
//

import Foundation
import RealmSwift

class SignShopDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var chain: String = ""
    @objc dynamic var categoryId: Int = 0
    @objc dynamic var categoryName: String = ""
    @objc dynamic var logo: String = ""
    let localisations = List<ShopDB>()

    override static func primaryKey() -> String? {
        "id"
    }
}

extension SignShopDB {
    func toResponse() -> SignShopResponse {
        return SignShopResponse(id: self.id,
                                chain: self.chain,
                                categoryId: self.categoryId,
                                categoryName: self.categoryName,
                                logo: self.logo,
                                localisations: self.localisations.map { $0.toResponse() })
    }
}

class ShopDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var zipcode: String = ""
    @objc dynamic var city: String = ""

    override static func primaryKey() -> String? {
        "id"
    }
}

extension ShopDB {
    func toResponse() -> ShopResponse {
        return ShopResponse(id: self.id,
                            name: self.name,
                            address: self.address,
                            zipcode: self.zipcode,
                            city: self.city)
    }
}

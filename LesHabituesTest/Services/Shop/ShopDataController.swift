//
//  ShopDataController.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 03/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import Result
import RxSwift

public enum ShopError: Error {
    case failFetchingShops(Error)
}

public final class ShopDataController {
    private let provider: Provider<ShopService>

    public init() {
        provider = Provider<ShopService>()
    }

    public func getShops() -> Single<Result<ShopListResponse, ShopError>> {
        let decoder = JSONDecoder()
        return provider
            .request(.list)
            .map(ShopListResponse.self, atKeyPath: nil, using: decoder, failsOnEmptyData: true)
            .map {response in
                return Result.success(response)
            }.catchError({ error -> PrimitiveSequence<SingleTrait, Result<ShopListResponse, ShopError>> in
                return Single.just(.failure(.failFetchingShops(error)))
            })
    }
}

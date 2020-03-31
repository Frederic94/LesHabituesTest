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

    public func getShops() -> Observable<Result<[SignShopResponse], ShopError>> {
        let remote = remoteGetShops().do(onSuccess: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let signShops):
                self.saveShops(signShops: signShops)
            case .failure:
                return
            }
        }).asObservable()
        let locale = localGetShops()
        return Observable.merge(remote, locale)
    }
    
    public func getLocaleSignShop(id: Int) -> Observable<SignShopResponse> {
        let database = try! RealmDatabase()
        let predicate = NSPredicate(format: "id == %i", id)
        return database.fetchObservable(SignShopDB.self, predicate: predicate)
        .flatMap { array -> Observable<SignShopResponse> in
            guard let first = array.first else { return .never() }
            return .just(first.toResponse())
        }
    }
}

private extension ShopDataController {
    func remoteGetShops() -> Single<Result<[SignShopResponse], ShopError>> {
        let decoder = JSONDecoder()
        return provider
            .request(.list)
            .map(SignShopListResponse.self, atKeyPath: nil, using: decoder, failsOnEmptyData: true)
            .map {response in
                return Result.success(response.data)
            }.catchError({ error in
                return Single.just(.failure(.failFetchingShops(error)))
            })
    }
    
    func localGetShops() -> Observable<Result<[SignShopResponse], ShopError>> {
        let database = try! RealmDatabase()
        return database.fetchObservable(SignShopDB.self, predicate: nil)
            .map { Result.success($0.map { $0.toResponse()}) }
        
    }
    
    func saveShops(signShops: [SignShopResponse]) {
        let database = try! RealmDatabase()
        let data = signShops.map { $0.toDB() }
        try? database.save(objects: data)
    }
}

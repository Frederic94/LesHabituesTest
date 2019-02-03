//
//  Provider.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 03/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import RxSwift

final class Provider<Target> where Target: Moya.TargetType {
    private var provider: MoyaProvider<Target>!
    private let disposeBag = DisposeBag()

    init() {
        self.provider = MoyaProvider<Target>()
    }

    public func request(_ token: Target) -> Single<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        return actualRequest
    }
}


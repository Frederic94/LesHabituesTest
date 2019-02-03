//
//  ShopService.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 03/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import Moya

public enum ShopService: TargetType {
    case list

    public var baseURL: URL {
        return URL(string: APIConfig.baseURL)!
    }

    public var path: String {
        switch self {
        case .list:
            return "/shops"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .list:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .list:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return nil
    }
}


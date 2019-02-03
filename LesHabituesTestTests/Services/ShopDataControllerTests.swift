//
//  ShopDataControllerTests.swift
//  LesHabituesTestUITests
//
//  Created by Frederic Mallet on 03/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest

@testable import LesHabituesTest

enum ShopDataControllerError: Error {
    case failGetShopsTest
}

final class ShopDataControllerTests: XCTestCase {

    var dataController: ShopDataController!
    private var disposeBag = DisposeBag()
    private var scheduler: TestScheduler!


    override func setUp() {
        super.setUp()
        self.dataController = ShopDataController()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetShops() {
        do {
            guard let result = try dataController.getShops().toBlocking(timeout: 5.0).first() else {
                throw ShopDataControllerError.failGetShopsTest
            }

            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                 XCTFail("Error_getshops: \(error.localizedDescription)")
            }
        } catch let error {
            XCTFail("Error_getshops: \(error.localizedDescription)")
        }
    }
}

//
//  Steps.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import RxFlow

indirect enum AppStep: Step {
    case shopList
    case signShopDetail(Int)
}

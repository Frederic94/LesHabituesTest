//
//  ViewModelType.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import Foundation
import RxFlow

protocol ViewModelType: HasDisposeBag {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}

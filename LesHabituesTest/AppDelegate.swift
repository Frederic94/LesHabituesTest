//
//  AppDelegate.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 03/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import UIKit
import RxFlow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // RxFlow stuff
    var coordinator = Coordinator()
    var appFlow: AppFlow!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = self.window else { return false }
        // Override point for customization after application launch.
        appFlow = AppFlow(withWindow: window)
        coordinator.coordinate(flow: appFlow, withStepper: OneStepper(withSingleStep: AppStep.shopList))

        return true
    }
}


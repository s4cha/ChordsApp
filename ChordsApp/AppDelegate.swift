//
//  AppDelegate.swift
//  ChordsApp
//
//  Created by Sacha on 23/12/2019.
//  Copyright © 2019 sachadso. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIHostingController(rootView: App())
        window?.makeKeyAndVisible()
        return true
    }
}


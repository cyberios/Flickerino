//
//  AppDelegate.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return setupApp()
    }

    private func setupApp() -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if (window == nil) {
            return false
        }
        
        let tape_view = UINavigationController(rootViewController: TapeAssembler.createModule())
        window?.rootViewController = tape_view
        window?.makeKeyAndVisible()
        return true
    }


}


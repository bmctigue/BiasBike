//
//  AppDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/29/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        let controller: SplashViewController = storyboard.instantiateInitialViewController() as! SplashViewController
        self.window?.rootViewController = controller
        
//        SyncUser.current?.logOut()
        
//        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
//        let realmURLs = [
//            realmURL,
//            realmURL.appendingPathExtension("lock"),
//            realmURL.appendingPathExtension("log_a"),
//            realmURL.appendingPathExtension("log_b"),
//            realmURL.appendingPathExtension("note")
//        ]
//        for URL in realmURLs {
//            do {
//                try FileManager.default.removeItem(at: URL)
//            } catch {
//                // handle error
//            }
//        }
        
        return true
    }
}


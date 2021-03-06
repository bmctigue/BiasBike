//
//  Realm.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/27/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

private var realm: Realm!

func logIn(animated: Bool = true) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyboard = StoryboardFactory().create(name: "RealmSyncLogin")
    let logInViewController = storyboard.instantiateInitialViewController() as! LogInViewController
    logInViewController.completionHandler = { username, password, returnCode in
        guard returnCode != .Cancel, let username = username, let password = password else {
            // FIXME: handle cancellation properly or just restrict it
            DispatchQueue.main.async {
                logIn()
            }
            return
        }
        authenticate(username: username, password: password, register: returnCode == .Register) { error in
            if let error = error {
                presentError(error: error)
            } else {
                if UserController.sharedInstance.all().count == 0 {
                    ModelControllerUtilities().loadAllModelControllers()
                }
                loadMainView()
            }
        }
    }
    appDelegate.window?.rootViewController?.present(logInViewController, animated: false, completion: nil)
    
    UIView.transition(with: appDelegate.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: {
        (value: Bool) in
        appDelegate.window?.rootViewController = logInViewController
    })
}

func loadMainView() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyboard = StoryboardFactory().create(name: "Main")
    let controller: UITabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
    appDelegate.window?.rootViewController = controller
    
    UIView.transition(with: appDelegate.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: {
        (value: Bool) in
        appDelegate.window?.rootViewController = controller
    })
}

func presentError(error: NSError) {
    let alertController = UIAlertController(title: error.localizedDescription,
                                            message: error.localizedFailureReason ?? "",
                                            preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Try Again", style: .default) { _ in
        logIn()
    })
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
}

private func setDefaultRealmConfigurationWithUser(user: SyncUser) {
    Realm.Configuration.defaultConfiguration = user.configuration(realmURL: Constants.syncServerURL! as URL, fullSynchronization: true, enableSSLValidation: true, urlPrefix: nil)
    
    do {
        realm = try Realm()
    } catch let error as NSError {
        NSLog("Error opening Realm: \(error.localizedDescription)")
    }
    
}

func configureDefaultRealm() -> Bool {
    if let user = SyncUser.current {
        setDefaultRealmConfigurationWithUser(user: user)
        return true
    }
    return false
}

func authenticate(username: String, password: String, register: Bool, callback: @escaping (NSError?) -> ()) {
    let credential = SyncCredentials.usernamePassword(username: username, password: password)
    SyncUser.logIn(with: credential, server: Constants.syncAuthURL as URL, onCompletion: { user, error in
        if let user = user {
            setDefaultRealmConfigurationWithUser(user: user)
        }
        if let error = error {
            callback(NSError(error: error as NSError, description: error.localizedDescription, recoverySuggestion: "Please check username and password or register a new account."))
        } else {
            callback(error as NSError?)
        }
    })
}

private extension NSError {
    convenience init(error: NSError, description: String?, recoverySuggestion: String?) {
        var userInfo = error.userInfo
        
        userInfo[NSLocalizedDescriptionKey] = description
        userInfo[NSLocalizedRecoverySuggestionErrorKey] = recoverySuggestion
        
        self.init(domain: error.domain, code: error.code, userInfo: userInfo)
    }
}

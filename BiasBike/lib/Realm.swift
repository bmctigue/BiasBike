//
//  Realm.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/27/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

private var realm: Realm! // FIXME: shouldn't have to hold on to the Realm here. https://github.com/realm/realm-sync/issues/694

private func setDefaultRealmConfigurationWithUser(user: User) {
    
    var configuration = Realm.Configuration()
    configuration.syncConfiguration = (user, Constants.syncServerURL! as URL)
    realm = try! Realm(configuration: configuration)
    
}

// Internal Functions

// returns true on success
func configureDefaultRealm() -> Bool {
    if let user = User.all().first {
        setDefaultRealmConfigurationWithUser(user: user)
        return true
    }
    return false
}

func authenticate(username: String, password: String, register: Bool, callback: @escaping (NSError?) -> ()) {
    User.authenticate(with: .usernamePassword(username: username, password: password, actions: register ? [.createAccount] : []), server: Constants.syncAuthURL as URL, onCompletion: { user, error in
        if let user = user {
            setDefaultRealmConfigurationWithUser(user: user)
        }
        
        if let error = error {
            let httpError = error as! SyncError
            if httpError.code == SyncError.httpStatusCodeError && httpError.errorCode == 400 {
                // FIXME: workararound for https://github.com/realm/realm-cocoa-private/issues/204
                // Note: "account not found" and "wrong password" have the same error code, so will show general error message for now
                callback(NSError(error: error as NSError, description: "Incorrect username or password.", recoverySuggestion: "Please check username and password or register a new account."))
            }
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

//
//  UserController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

final class UserController: ModelController {
    
    static let sharedInstance = UserController.init()
    
    func all() -> [User] {
        let items = realm.objects(User.self)
        if items.count == 0 {
            return [User]()
        }
        return Array(items)
    }
    
    func find(key: String) -> User? {
        return realm.object(ofType: User.self, forPrimaryKey: key)
    }
    
    func userRatingsHash() -> [String:Int] {
        let items = all()
        var hash: [String:Int] = [:]
        for user: User in items {
            let ratings = RatingController.sharedInstance.all(userId: user.userId)
            hash[user.userId] = RatingController.sharedInstance.latestRating(ratings:ratings)
        }
        return hash
    }
    
    func userAggRatingsHash() -> [String:Int] {
        let items = all()
        var hash: [String:Int] = [:]
        for user: User in items {
            let ratings = RatingController.sharedInstance.all(userId: user.userId)
            hash[user.userId] = RatingController.sharedInstance.averageRating(ratings:ratings)
        }
        return hash
    }
    
    func loadDefault() {
        clear()
        let userFactory = UserFactory()
        _ = userFactory.create(firstName: "Bruce", lastName: "McTigue", url: "bruce")
        _ = userFactory.create(firstName: "Karen", lastName: "Knisely", url: "karen")
    }
}

//
//  UserController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

final class UserController: ModelController<User> {
    
    static let sharedInstance = UserController.init(modelType: ModelType.User)
    
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
    
    override func loadDefault() {
        clear()
        let userFactory = UserFactory()
        let user1 = userFactory.create(firstName: "Bruce", lastName: "McTigue", creationDate: Date(), url: "bruce")
        update(key: user1.userId, item: user1)
        let user2 = userFactory.create(firstName: "Julia", lastName: "Galef", creationDate: Date(), url: "julia")
        update(key: user2.userId, item: user2)
    }
}

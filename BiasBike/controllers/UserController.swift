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
            hash[user.userId] = RatingController.sharedInstance.latestRating(modelId: user.userId)
        }
        return hash
    }
    
    func userAggRatingsHash() -> [String:Int] {
        let items = all()
        var hash: [String:Int] = [:]
        for user: User in items {
            hash[user.userId] = RatingController.sharedInstance.averageRating(modelId: user.userId)
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
        let user3 = userFactory.create(firstName: "Karen", lastName: "Knisely", creationDate: Date(), url: "karen")
        update(key: user3.userId, item: user3)
    }
}

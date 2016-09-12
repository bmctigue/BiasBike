//
//  UserController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class UserController: ModelController<User> {
    
    static let sharedInstance = UserController.init(modelType: ModelType.User)
    
    override func loadDefault() {
        clear()
        let userFactory = UserFactory()
        let user1 = userFactory.create(firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "", rtRating: 45, aggRR: 50)
        update(key: user1.userId, item: user1)
        let user2 = userFactory.create(firstName: "Tom", lastName: "Slick", creationDate: Date(), url: "", rtRating: 90, aggRR: 65)
        update(key: user2.userId, item: user2)
    }
}

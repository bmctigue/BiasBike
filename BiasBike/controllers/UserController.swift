//
//  UserController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class UserController: ModelController<User> {
    
    static let sharedInstance = EvidenceController.init(modelType: ModelType.User)
    
    let modelController = ModelController<User>.init(modelType: ModelType.User)
    
    override func all() -> [User] {
        return modelController.all()
    }
    
    override func add(item: User) {
        modelController.add(item: item)
    }
}

extension UserController {
    
    func loadDefault() {
        clear()
        let user1 = User(userId: "1", firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "", rtRating: 45, aggRR: 50)
        add(item: user1)
        let user2 = User(userId: "2", firstName: "Tom", lastName: "Slick", creationDate: Date(), url: "", rtRating: 90, aggRR: 65)
        add(item: user2)
    }
    
}

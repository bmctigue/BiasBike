//
//  UserFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol UserFactoryProtocol {
    func create(userId: String, firstName: String, lastName: String, creationDate: Date, url: String, rtRating: Int, aggRR: Int) -> User
}

struct UserFactory: UserFactoryProtocol {
    func create(userId: String, firstName: String, lastName: String, creationDate: Date, url: String, rtRating: Int, aggRR: Int) -> User {
        return User.init(userId: userId, firstName: firstName, lastName: lastName, creationDate: creationDate, url: url, rtRating: rtRating, aggRR: aggRR)
    }
}

//
//  UserFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

protocol UserFactoryProtocol {
    func create(firstName: String, lastName: String, url: String) -> BiasUser
}

struct UserFactory: UserFactoryProtocol {
    func create(firstName: String, lastName: String, url: String) -> BiasUser {
        return BiasUser(value: [firstName: firstName, lastName: lastName, url: url])
    }
}

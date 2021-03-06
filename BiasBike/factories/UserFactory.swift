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
    func create(firstName: String, lastName: String, url: String) -> User
}

struct UserFactory: UserFactoryProtocol {
    func create(firstName: String, lastName: String, url: String) -> User {
        let user = User(value: ["firstName": firstName, "lastName": lastName, "url": url])
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
        }
        return user
    }
}

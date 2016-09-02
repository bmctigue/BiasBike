//
//  UserController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class UserController {
    
    static let sharedInstance = UserController()
    private init() {}
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("user")
    
    private(set) var users: [User] = {
        if let users = NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? [User] {
            return users
        } else {
            return [User]()
        }
    }()
    
    func clearUsers() {
        self.users.removeAll()
    }
    
    func addUser(user: User) {
        self.users.append(user)
    }
    
    func save() {
        let castedItems = self.users as NSArray
        NSKeyedArchiver.archiveRootObject(castedItems,toFile: UserController.ArchiveURL.path)
    }
}

extension UserController {
    
    func loadDefaultUsers() {
        clearUsers()
        let user1 = User(userId: "1", firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "", rtRating: 45, aggRR: 50)
        addUser(user: user1)
        let user2 = User(userId: "2", firstName: "Tom", lastName: "Slick", creationDate: Date(), url: "", rtRating: 90, aggRR: 65)
        addUser(user: user2)
        save()
    }
    
}

//
//  ModelController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/7/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

class ModelController {
    
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func clear() {
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
    
}

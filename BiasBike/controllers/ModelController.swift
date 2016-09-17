//
//  ModelController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/7/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

enum ModelType: String {
    case Generic = "generic"
    case Event = "events"
    case Claim = "claims"
    case Evidence = "evidence"
    case User = "users"
}

class ModelController<T> {
    
    var hash: [String:T]
    var modelType: ModelType
    let archiveURL: URL
    
    init(modelType: ModelType) {
        self.hash = [:]
        self.modelType = modelType
        self.archiveURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(self.modelType.rawValue)
    }
    
    func all() -> [T] {
        if let hash = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? [String:T] {
            self.hash = hash
            return Array(hash.values)
        } else {
            return [T]()
        }
    }
    
    func clear() {
        self.hash.removeAll()
    }
    
    func update(key: String, item: T) {
        self.hash[key] = item
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(self.hash as NSDictionary,toFile: archiveURL.path)
    }
    
    func loadDefault() {
        // load default items here
    }
    
}

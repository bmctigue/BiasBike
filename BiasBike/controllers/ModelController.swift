//
//  ModelController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/7/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

enum ModelType: String {
    case Event = "events"
    case Claim = "claims"
    case Evidence = "evidence"
    case User = "users"
}

class ModelGenericType {
   // used for ModelController class method calls.
}

class ModelController<T> {
    
    var items: [T] = []
    var modelType: ModelType
    let archiveURL: URL
    
    init(modelType: ModelType) {
        self.modelType = modelType
        self.archiveURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(self.modelType.rawValue)
        self.items = all()
    }
    
    func all() -> [T] {
        if let items = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? [T] {
            return items
        } else {
            return [T]()
        }
    }
    
    func clear() {
        items.removeAll()
        save()
    }
    
    func add(item: T) {
        items.append(item)
        save()
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(self.items as NSArray,toFile: archiveURL.path)
    }
    
}

extension ModelController {
    class func saveAllControllers() {
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.save()
        UserController.sharedInstance.save()
        
    }
}

//
//  FallacyController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

final class FallacyController: ModelController {
    
    static let sharedInstance = FallacyController.init()
    
    func all() -> [Fallacy] {
        let items = realm.objects(Fallacy.self)
        if items.count == 0 {
            return [Fallacy]()
        }
        return Array(items)
    }
    
    func find(key: String) -> Fallacy? {
        return realm.object(ofType: Fallacy.self, forPrimaryKey: key)
    }
    
    func update(item: Fallacy) {
        try! self.realm.write {
            self.realm.add(item, update: true)
        }
    }
    
    func loadDefault() {
        let fallacyFactory = FallacyFactory()
        let fallacy1 = fallacyFactory.create(title: "Anonymous Authority", summary: "An argument's proponent justifies it by appeal to an unidentified authority.", example: "Experts say that gluten is bad for you: hence, I should avoid gluten.", url: "", icon: FallacIcons.AnonymousAuthority.rawValue)
        update(item: fallacy1)
        let fallacy2 = fallacyFactory.create(title: "Appeal to Anger", summary: "Attacking an opponent's argument on the grounds that it angers you or your audience.", example: "", url: "", icon: FallacIcons.Anger.rawValue)
        update(item: fallacy2)
        let fallacy3 = fallacyFactory.create(title: "Appeal to Authority", summary: "Attempting to support an argument, not offering any direct evidence for the argument, but by appealing to the testimony of an authority.", example: "", url: "", icon: FallacIcons.Authority.rawValue)
        update(item: fallacy3)
    }
}

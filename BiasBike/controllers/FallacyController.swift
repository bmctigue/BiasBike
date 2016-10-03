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
    
    func all(type: String) -> [Fallacy] {
        let items = all()
        return items.filter{$0.type == type}
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
        let fallacy1  = fallacyFactory.create(title: FallacyType.AnonymousAuthority.title, summary: FallacyType.AnonymousAuthority.summary, example: FallacyType.AnonymousAuthority.example, url: "", icon: FallacyType.AnonymousAuthority.icon, type: FallacyType.AnonymousAuthority.rawValue)
        update(item: fallacy1)
        let fallacy2 = fallacyFactory.create(title: FallacyType.Anger.title, summary: FallacyType.Anger.summary, example: FallacyType.Anger.example, url: "", icon: FallacyType.Anger.icon, type: FallacyType.Anger.rawValue)
        update(item: fallacy2)
        let fallacy3 = fallacyFactory.create(title: FallacyType.Authority.title, summary: FallacyType.Authority.summary, example: FallacyType.Authority.example, url: "", icon: FallacyType.Authority.icon, type: FallacyType.Authority.rawValue)
        update(item: fallacy3)
    }
}

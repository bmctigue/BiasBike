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
        let fallacy1 = fallacyFactory.create(title: FallacIcons.AnonymousAuthority.title, summary: FallacIcons.AnonymousAuthority.summary, example: FallacIcons.AnonymousAuthority.example, url: "", icon: FallacIcons.AnonymousAuthority.icon)
        update(item: fallacy1)
        let fallacy2 = fallacyFactory.create(title: FallacIcons.Anger.title, summary: FallacIcons.Anger.summary, example: FallacIcons.Anger.example, url: "", icon: FallacIcons.Anger.icon)
        update(item: fallacy2)
        let fallacy3 = fallacyFactory.create(title: FallacIcons.Authority.title, summary: FallacIcons.Authority.summary, example: FallacIcons.Authority.example, url: "", icon: FallacIcons.Authority.icon)
        update(item: fallacy3)
    }
}

//
//  FallacyFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

protocol FallacyFactoryProtocol {
    func create(title: String, summary: String, example: String, url: String, icon: String, type: String) -> Fallacy
}

struct FallacyFactory: FallacyFactoryProtocol {
    func create(title: String, summary: String, example: String, url: String, icon: String, type: String) -> Fallacy {
        let fallacy = Fallacy(value: ["title": title, "summary": summary, "example": example, "url": url, "icon": icon, "type": type])
        let realm = try! Realm()
        try! realm.write {
            realm.add(fallacy)
        }
        return fallacy
    }
}

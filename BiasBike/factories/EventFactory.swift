//
//  EventFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

protocol EventFactoryProtocol {
    func create(title: String, summary: String, url: String, photoUrl: String, category: String) -> Event
}

struct EventFactory: EventFactoryProtocol {
    func create(title: String, summary: String, url: String, photoUrl: String, category: String) -> Event {
        let event = Event(value: ["title": title, "summary": summary, "url": url, "photoUrl": photoUrl, "category": category])
        let realm = try! Realm()
        try! realm.write {
            realm.add(event)
        }
        return event
    }
}

//
//  EventFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol EventFactoryProtocol {
    func create(eventId: String, title: String, summary: String, creationDate: Date, url: String, photoUrl: String, category: Category, claims: [Claim]) -> Event
}

struct EventFactory: EventFactoryProtocol {
    func create(eventId: String, title: String, summary: String, creationDate: Date, url: String, photoUrl: String, category: Category, claims: [Claim]) -> Event {
        return Event.init(eventId: eventId, title: title, summary: summary, creationDate: creationDate, url: url, photoUrl: photoUrl, category: category, claims: claims)
    }
}

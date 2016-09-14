//
//  EventFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol EventFactoryProtocol {
    func create(title: String, summary: String, creationDate: Date, url: String, photoUrl: String, aggProbability: Int, category: CategoryType) -> Event
}

struct EventFactory: EventFactoryProtocol {
    func create(title: String, summary: String, creationDate: Date, url: String, photoUrl: String, aggProbability: Int, category: CategoryType) -> Event {
        return Event.init(title: title, summary: summary, creationDate: creationDate, url: url, photoUrl: photoUrl, aggProbability: aggProbability, category: category)
    }
}

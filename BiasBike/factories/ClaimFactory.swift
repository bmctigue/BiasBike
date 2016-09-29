//
//  ClaimFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol ClaimFactoryProtocol {
    func create(title: String, summary: String, url: String, eventId: String, userId: String) -> Claim
}

struct ClaimFactory: ClaimFactoryProtocol {
    func create(title: String, summary: String, url: String, eventId: String, userId: String) -> Claim {
        return Claim(value: ["title": title, "summary": summary, "url": url, "eventId": eventId, "userId": userId])
    }
}

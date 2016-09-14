//
//  ClaimFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol ClaimFactoryProtocol {
    func create(title: String, summary: String, creationDate: Date, url: String, probability: Int, aggProbability: Int) -> Claim
}

struct ClaimFactory: ClaimFactoryProtocol {
    func create(title: String, summary: String, creationDate: Date, url: String, probability: Int, aggProbability: Int) -> Claim {
        return Claim.init(title: title, summary: summary, creationDate: creationDate, url: url, probability: probability, aggProbability: aggProbability)
    }
}
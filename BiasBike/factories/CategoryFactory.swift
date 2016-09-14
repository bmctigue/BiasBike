//
//  CategoryFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol CategoryFactoryProtocol {
    func create(type: CategoryType) -> CategoryProtocol
}

struct CategoryFactory: CategoryFactoryProtocol {
    func create(type: CategoryType) -> CategoryProtocol {
        switch type {
        case .World:
            return WorldCategory()
        case .Sports:
            return SportsCategory()
        case .Myths:
            return MythsCategory()
        case .Religion:
            return ReligionCategory()
        case .Health:
            return HealthCategory()
        case .Science:
            return ScienceCategory()
        case .Politics:
            return PoliticsCategory()
        }
    }
}

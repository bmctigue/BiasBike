//
//  Category.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

enum CategoryType: String {
    case World = "World"
    case Sports = "Sports"
    case Myths = "Myths"
    case Religion = "Religion"
    case Health = "Health"
    case Science = "Science"
    case Politics = "Politics"
    // the order here controls the order in the table
    static let categories = [World, Sports, Myths, Religion, Health, Science, Politics]
}

protocol CategoryProtocol {
    var color: UIColor { get }
}

struct WorldCategory: CategoryProtocol {
    var color: UIColor = .magenta
}

struct SportsCategory: CategoryProtocol {
    var color: UIColor = .blue
}

struct MythsCategory: CategoryProtocol {
    var color: UIColor = .cyan
}

struct ReligionCategory: CategoryProtocol {
    var color: UIColor = .red
}

struct HealthCategory: CategoryProtocol {
    var color: UIColor = .green
}

struct ScienceCategory: CategoryProtocol {
    var color: UIColor = .yellow
}

struct PoliticsCategory: CategoryProtocol {
    var color: UIColor = .orange
}

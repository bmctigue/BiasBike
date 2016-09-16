//
//  Category.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

enum Category: String {
    case World = "World"
    case Sports = "Sports"
    case Myths = "Myths"
    case Religion = "Religion"
    case Health = "Health"
    case Science = "Science"
    case Politics = "Politics"
    
    var color: UIColor {
        switch self {
        case .World:
            return .magenta
        case .Sports:
            return .blue
        case .Myths:
            return .cyan
        case .Religion:
            return .red
        case .Health:
            return .green
        case .Science:
            return .yellow
        case .Politics:
            return .orange
        }
    }
    
    // the order here controls the order in the table
    static let categories = [World, Sports, Myths, Religion, Health, Science, Politics]
}

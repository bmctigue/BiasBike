//
//  Category.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

enum Category: String {
    case World = "World"
    case News = "News"
    case Myths = "Myths"
    case Religion = "Religion"
    case Health = "Health"
    case Science = "Science"
    case Politics = "Politics"
    static let categories = [World, News, Myths, Religion, Health, Science, Politics]
}

class CategoryController: NSObject {
    
    static let sharedInstance = CategoryController.init()

    func categoryFromSortedCategories(section: Int, categoryHash:[String:[Event]]) -> Category {
        let sortedCategories = Category.categories.filter{Array(categoryHash.keys).contains($0.rawValue)}
        let category = sortedCategories[section]
        return category
    }
}

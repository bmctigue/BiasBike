//
//  CategoriesTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class CategoriesTableViewDelegate: NSObject {
    
    private(set) var categories:[CategoryType] = []
    var selectedCategories:[CategoryType] = []

    init(tableView: UITableView) {
        self.categories = CategoryType.categories
        self.selectedCategories = CategoryController().loadSelectedCategories()
        super.init()
        tableView.delegate = self
    }
    
    func saveSelectedCategories() {
        CategoryController().saveSelectedCategories(categories: selectedCategories)
    }
}

extension CategoriesTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.rawValue
        if selectedCategories.contains(category) {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.bottom)
        } else {
            cell.accessoryType = .none
        }
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        let category = categories[indexPath.row]
        if !selectedCategories.contains(category) {
            selectedCategories.append(category)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        let category = categories[indexPath.row]
        if selectedCategories.contains(category) {
            let index: Int = selectedCategories.index(of: category)!
            selectedCategories.remove(at: index)
        }
    }
}

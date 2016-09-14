//
//  CategoryTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class CategoryTableViewDelegate: NSObject {
    
    private(set) var categoryHash:[String:[Event]] = [:]
    private(set) var category: CategoryType

    init(tableView: UITableView, categoryType: CategoryType) {
        self.category = categoryType
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(categoryHash: [String:[Event]]) {
        self.categoryHash = categoryHash
    }
}

extension CategoryTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            cell.updateCell(title: event.title, photoUrl: event.photoUrl)
        }
    }
}

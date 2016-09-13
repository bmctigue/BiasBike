//
//  EventTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventTableViewDelegate: NSObject {
    
    var categoryHash:[String:[Event]] = [:]

    init(tableView: UITableView) {
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(categoryHash: [String:[Event]]) {
        self.categoryHash = categoryHash
    }
}

extension EventTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
        let category = CategoryController.sharedInstance.categoryFromSortedCategories(section: indexPath.section, categoryHash:categoryHash)
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            cell.updateCell(title: event.title, photoUrl: event.photoUrl)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:EventHeaderCell = tableView.dequeueReusableCell(withIdentifier: "EventHeaderCell") as! EventHeaderCell
        let category = CategoryController.sharedInstance.categoryFromSortedCategories(section: section, categoryHash:categoryHash)
        cell.update(category: category.rawValue)
        return cell
    }
}

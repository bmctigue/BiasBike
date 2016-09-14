//
//  EventTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventTableViewDelegate: NSObject {
    
    private(set) var categoryHash:[String:[Event]] = [:]
    private(set) var sortedCategories:[CategoryType] = []

    init(tableView: UITableView) {
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(categoryHash: [String:[Event]]) {
        self.categoryHash = categoryHash
        self.sortedCategories = CategoryType.categories.filter{Array(categoryHash.keys).contains($0.rawValue)}
    }
}

extension EventTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
        let category = sortedCategories[indexPath.section]
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
        let category = sortedCategories[section]
        cell.update(type: category)
        return cell
    }
}

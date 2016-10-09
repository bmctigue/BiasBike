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
    private(set) var category: Category
    private(set) var uniqueFallaciesPerEventHash: [String:[Fallacy]] = [:]
    private(set) weak var categoryTableViewController: CategoryTableViewController?
    private(set) weak var tableView: UITableView!

    init(tableView: UITableView, category: Category, categoryTableViewController: CategoryTableViewController? ) {
        self.category = category
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        self.categoryTableViewController = categoryTableViewController
    }
    
    func updateDataSource(categoryHash: [String:[Event]]) {
        self.categoryHash = categoryHash
        self.uniqueFallaciesPerEventHash = FallacyController.sharedInstance.uniqueFallaciesPerEventHash()
    }
}

extension CategoryTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            let fallacies = uniqueFallaciesPerEventHash[event.eventId]
            if let fallacies = fallacies {
                cell.updateCell(title: event.title, photoUrl: event.photoUrl, fallacies: fallacies)
            } else {
                cell.updateCell(title: event.title, photoUrl: event.photoUrl, fallacies: [])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            let storyboard = UIStoryboard(name: "Claim", bundle: nil)
            let controller: ClaimsTableViewController = storyboard.instantiateViewController(withIdentifier: "ClaimsTableViewController") as! ClaimsTableViewController
            controller.eventId = event.eventId
            controller.title = event.title
            categoryTableViewController?.show(controller, sender: nil)
        }
    }
}

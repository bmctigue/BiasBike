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
    private(set) weak var categoryTableViewController: CategoryTableViewController?

    init(tableView: UITableView, categoryType: CategoryType, categoryTableViewController: CategoryTableViewController? ) {
        self.categoryTableViewController = categoryTableViewController
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            let storyboard = UIStoryboard(name: "Claim", bundle: nil)
            let controller: ClaimsTableViewController = storyboard.instantiateViewController(withIdentifier: "ClaimsTableViewController") as! ClaimsTableViewController
            controller.eventId = event.eventId
            categoryTableViewController?.show(controller, sender: nil)
        }
    }
}

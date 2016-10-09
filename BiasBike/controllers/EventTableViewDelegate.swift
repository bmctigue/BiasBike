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
    private(set) var sortedCategories:[Category] = []
    private(set) var uniqueFallaciesViewHash: [String:UIView] = [:]
    private(set) weak var eventTableViewController: EventTableViewController?
    private(set) weak var tableView: UITableView!

    init(tableView: UITableView, eventTableViewController: EventTableViewController? ) {
        super.init()
        self.tableView = tableView
        tableView.delegate = self
        self.eventTableViewController = eventTableViewController
    }
    
    func updateDataSource(categoryHash: [String:[Event]]) {
        self.categoryHash = categoryHash
        self.sortedCategories = CategoryController().filteredCategoryTypes(categoryHash: categoryHash)
        self.uniqueFallaciesViewHash = FallacyController.sharedInstance.uniqueFallaciesViewHash()
    }
}

extension EventTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
        let category = sortedCategories[indexPath.section]
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            cell.updateCell(title: event.title, photoUrl: event.photoUrl, fallacyView: uniqueFallaciesViewHash[event.eventId])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:EventHeaderCell = tableView.dequeueReusableCell(withIdentifier: "EventHeaderCell") as! EventHeaderCell
        let category = sortedCategories[section]
        cell.delegate = self
        cell.update(category: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = sortedCategories[indexPath.section]
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            let storyboard = UIStoryboard(name: "Claim", bundle: nil)
            let controller: ClaimsTableViewController = storyboard.instantiateViewController(withIdentifier: "ClaimsTableViewController") as! ClaimsTableViewController
            controller.eventId = event.eventId
            controller.eventTitle = event.title
            eventTableViewController?.show(controller, sender: nil)
        }
    }
}

extension EventTableViewDelegate: EventHeaderCellDelegate {
    
    func headerButtonPressed(category: Category) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: CategoryTableViewController = storyboard.instantiateViewController(withIdentifier: "CategoryTableViewController") as! CategoryTableViewController
        controller.category = category
        eventTableViewController?.show(controller, sender: nil)
    }
}

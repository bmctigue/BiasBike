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
    private(set) var eventRatingsHash: [String:[Rating]] = [:]
    private(set) var aggRatingsPerEventHash: [String:Int] = [:]
    private(set) var uniqueFallaciesPerEventHash: [String:[Fallacy]] = [:]
    private(set) weak var eventTableViewController: EventTableViewController?
    private(set) weak var tableView: UITableView!

    init(tableView: UITableView, eventTableViewController: EventTableViewController? ) {
        super.init()
        self.tableView = tableView
        tableView.delegate = self
        self.eventTableViewController = eventTableViewController
    }
    
    func updateDataSource(categoryHash: [String:[Event]], uniqueFallaciesPerEventHash: [String:[Fallacy]]) {
        self.categoryHash = categoryHash
        self.sortedCategories = CategoryController().filteredCategoryTypes(categoryHash: categoryHash)
        self.eventRatingsHash = RatingController.sharedInstance.eventRatingsHash()
        self.aggRatingsPerEventHash = RatingController.sharedInstance.aggRatingsPerEventHash(eventRatingsHash: eventRatingsHash)
        self.uniqueFallaciesPerEventHash = uniqueFallaciesPerEventHash
    }
}

extension EventTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
        let category = sortedCategories[indexPath.section]
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            let fallacies = uniqueFallaciesPerEventHash[event.eventId]
            var aggRating = aggRatingsPerEventHash[event.eventId]
            if aggRating == nil {
                aggRating = 0
            }
            if let fallacies = fallacies {
                cell.updateCell(title: event.title, photoUrl: event.photoUrl, aggRating: aggRating!, fallacies: fallacies)
            } else {
                cell.updateCell(title: event.title, photoUrl: event.photoUrl, aggRating: aggRating!, fallacies: [])
            }
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
            let storyboard = StoryboardFactory().create(name: "Claim")
            let controller: ClaimsTableViewController = storyboard.instantiateViewController(withIdentifier: "ClaimsTableViewController") as! ClaimsTableViewController
            controller.event = event
            eventTableViewController?.show(controller, sender: nil)
        }
    }
}

extension EventTableViewDelegate: EventHeaderCellDelegate {
    
    func headerButtonPressed(category: Category) {
        let storyboard = StoryboardFactory().create(name: "Main")
        let controller: CategoryTableViewController = storyboard.instantiateViewController(withIdentifier: "CategoryTableViewController") as! CategoryTableViewController
        controller.category = category
        eventTableViewController?.show(controller, sender: nil)
    }
}

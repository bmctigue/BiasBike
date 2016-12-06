//
//  EventTableViewDelegateCommon.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventTableViewDelegateCommon: NSObject {
    
    private(set) var categoryHash:[String:[Event]] = [:]
    private(set) var category: String = ""
    private(set) var sortedCategories:[Category] = []
    private(set) var eventRatingsHash: [String:[Rating]] = [:]
    private(set) var aggRatingsPerEventHash: [String:Int] = [:]
    private(set) var uniqueFallaciesPerEventHash: [String:[Fallacy]] = [:]
    private(set) weak var tableViewController: UITableViewController?
    private(set) weak var tableView: UITableView!

    init(tableView: UITableView, category: String, tableViewController: UITableViewController? ) {
        super.init()
        self.tableView = tableView
        tableView.delegate = self
        self.tableViewController = tableViewController
        self.category = category
    }
    
    func updateDataSource(categoryHash: [String:[Event]], uniqueFallaciesPerEventHash: [String:[Fallacy]]) {
        self.categoryHash = categoryHash
        self.sortedCategories = CategoryController().filteredCategoryTypes(categoryHash: categoryHash)
        self.eventRatingsHash = RatingController.sharedInstance.eventRatingsHash()
        self.aggRatingsPerEventHash = RatingController.sharedInstance.aggRatingsPerEventHash(eventRatingsHash: eventRatingsHash)
        self.uniqueFallaciesPerEventHash = uniqueFallaciesPerEventHash
    }
}

extension EventTableViewDelegateCommon: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
        let category = sortedCategories[indexPath.section].rawValue
        self.updateCell(cell: cell, category: category, indexPath: indexPath)
        
    }
    
    func updateCell(cell: EventCell, category: String, indexPath: IndexPath) {
        if let events = self.categoryHash[category] {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = sortedCategories[indexPath.section]
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            let storyboard = StoryboardFactory().create(name: "Claim")
            let controller: ClaimsTableViewController = storyboard.instantiateViewController(withIdentifier: "ClaimsTableViewController") as! ClaimsTableViewController
            controller.event = event
            tableViewController?.show(controller, sender: nil)
        }
    }
}

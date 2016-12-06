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
    private(set) var eventRatingsHash: [String:[Rating]] = [:]
    private(set) var aggRatingsPerEventHash: [String:Int] = [:]
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
    
    func updateDataSource(categoryHash: [String:[Event]], uniqueFallaciesPerEventHash: [String:[Fallacy]]) {
        self.categoryHash = categoryHash 
        self.eventRatingsHash = RatingController.sharedInstance.eventRatingsHash()
        self.aggRatingsPerEventHash = RatingController.sharedInstance.aggRatingsPerEventHash(eventRatingsHash: eventRatingsHash)
        self.uniqueFallaciesPerEventHash = uniqueFallaciesPerEventHash
    }
}

extension CategoryTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            let storyboard = StoryboardFactory().create(name: "Claim")
            let controller: ClaimsTableViewController = storyboard.instantiateViewController(withIdentifier: "ClaimsTableViewController") as! ClaimsTableViewController
            controller.event = event
            categoryTableViewController?.show(controller, sender: nil)
        }
    }
}

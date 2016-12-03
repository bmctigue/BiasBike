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
    private(set) var fallacyViewPerEventHash: [String:UIView] = [:]
    private(set) weak var categoryTableViewController: CategoryTableViewController?
    private(set) weak var tableView: UITableView!

    init(tableView: UITableView, category: Category, categoryTableViewController: CategoryTableViewController? ) {
        self.category = category
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        self.categoryTableViewController = categoryTableViewController
    }
    
    func updateDataSource(categoryHash: [String:[Event]],fallacyViewPerEventHash: [String:UIView]) {
        self.categoryHash = categoryHash
        self.eventRatingsHash = RatingController.sharedInstance.eventRatingsHash()
        self.aggRatingsPerEventHash = RatingController.sharedInstance.aggRatingsPerEventHash(eventRatingsHash: eventRatingsHash)
        self.fallacyViewPerEventHash = fallacyViewPerEventHash
    }
}

extension CategoryTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
        if let events = self.categoryHash[category.rawValue] {
            let event = events[indexPath.row]
            let fallacyView = fallacyViewPerEventHash[event.eventId]
            let aggRating = aggRatingsPerEventHash[event.eventId]
            if let fallacyView = fallacyView {
                cell.updateCell(title: event.title, photoUrl: event.photoUrl, aggRating: aggRating!, fallacyView: fallacyView)
            } else {
                cell.updateCell(title: event.title, photoUrl: event.photoUrl, aggRating: aggRating!, fallacyView: nil)
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

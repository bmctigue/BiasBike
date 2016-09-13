//
//  EventTableViewController.swift
//  Interview
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    @IBOutlet weak var titleLabel: UILabel!

    var tableViewDataSource: EventTableViewDataSource?
    var tableViewDelegate: EventTableViewDelegate?
    var categoryHash:[String:[Event]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News"

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(EventTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300

        self.tableViewDataSource = EventTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = EventTableViewDelegate(tableView: tableView)
        EventController.sharedInstance.loadDefault()
        refreshData()
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        refreshData()
        refreshControl.endRefreshing()
    }
    
    func refreshData() {
        self.categoryHash = EventController.sharedInstance.categoryHash()
        self.tableViewDataSource?.updateDataSource(categoryHash: categoryHash)
        self.tableViewDelegate?.updateDataSource(categoryHash: categoryHash)
        self.tableView.reloadData()
    }

}

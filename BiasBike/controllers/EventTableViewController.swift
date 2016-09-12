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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News"

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(EventTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        self.tableViewDataSource = EventTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = EventTableViewDelegate(tableView: tableView)
        
        EventController.sharedInstance.loadDefault()
        self.tableView.reloadData()
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

}

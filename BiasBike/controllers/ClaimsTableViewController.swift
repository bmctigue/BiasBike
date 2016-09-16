//
//  ClaimsTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ClaimsTableViewController: UITableViewController {

    private(set) var tableViewDataSource: ClaimsTableViewDataSource?
    private(set) var tableViewDelegate: ClaimsTableViewDelegate?
    var eventId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Claims"

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ClaimsTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        ClaimController.sharedInstance.loadDefault()
        self.tableViewDataSource = ClaimsTableViewDataSource(tableView: tableView, eventId:eventId)
        self.tableViewDelegate = ClaimsTableViewDelegate(tableView: tableView, eventId:eventId)
        refreshData()
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        refreshData()
        refreshControl.endRefreshing()
    }
    
    func refreshData() {
        self.tableViewDataSource?.updateDataSource(eventId:eventId)
        self.tableViewDelegate?.updateDataSource(eventId:eventId)
        self.tableView.reloadData()
    }

}

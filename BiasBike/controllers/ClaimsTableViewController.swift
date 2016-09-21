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
    var claims: [Claim] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ClaimsTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        self.tableViewDataSource = ClaimsTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = ClaimsTableViewDelegate(tableView: tableView, claimsTableViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        refreshData()
        refreshControl.endRefreshing()
    }
    
    func refreshData() {
        self.claims = ClaimController.sharedInstance.all(eventId: eventId)
        self.tableViewDataSource?.updateDataSource(claims: claims)
        self.tableViewDelegate?.updateDataSource(claims: claims, eventId: eventId)
        self.tableView.reloadData()
    }

}

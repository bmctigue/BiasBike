//
//  UsersTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    private(set) var tableViewDataSource: UsersTableViewDataSource?
    private(set) var tableViewDelegate: UsersTableViewDelegate?
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(UsersTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        self.tableViewDataSource = UsersTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = UsersTableViewDelegate(tableView: tableView, usersTableViewController: self)
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
        self.users = UserController.sharedInstance.all()
        self.tableViewDataSource?.updateDataSource(users: users)
        self.tableViewDelegate?.updateDataSource(users: users)
        self.tableView.reloadData()
    }
}

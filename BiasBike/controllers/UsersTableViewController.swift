//
//  UsersTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit
import RealmSwift

class UsersTableViewController: UITableViewController {
    
    let realm: Realm = try! Realm()
    var notificationToken: NotificationToken? = nil

    private(set) var tableViewDataSource: UsersTableViewDataSource?
    private(set) var tableViewDelegate: UsersTableViewDelegate?
    var users: [BiasUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(UsersTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        self.tableViewDataSource = UsersTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = UsersTableViewDelegate(tableView: tableView, usersTableViewController: self)
        
        notificationToken = realm.addNotificationBlock { notification, realm in
            self.refreshData()
        }
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        notificationToken?.stop()
    }
}

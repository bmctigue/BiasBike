//
//  CategoryTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    @IBOutlet weak var titleLabel: UILabel!

    private(set) var tableViewDataSource: CategoryTableViewDataSource?
    private(set) var tableViewDelegate: CategoryTableViewDelegate?
    private(set) var categoryHash:[String:[Event]] = [:]
    var categoryType: CategoryType = .World

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = categoryType.rawValue

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(CategoryTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300

        self.tableViewDataSource = CategoryTableViewDataSource(tableView: tableView, categoryType:categoryType)
        self.tableViewDelegate = CategoryTableViewDelegate(tableView: tableView, categoryType:categoryType, categoryTableViewController:self)
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
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

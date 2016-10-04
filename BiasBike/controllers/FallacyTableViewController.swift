//
//  FallacyTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallaciesTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var evidence: Evidence?
    private(set) var tableViewDataSource: FallaciesTableViewDataSource?
    private(set) var tableViewDelegate: FallaciesTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset.top = 20
        self.tableView.allowsMultipleSelection = true
        self.tableViewDataSource = FallaciesTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = FallaciesTableViewDelegate(tableView: tableView, evidence: evidence)
        self.tableView.reloadData()
    }
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        self.tableViewDelegate?.saveSelectedFallacies()
        self.dismiss(animated: true, completion: nil)
    }
    
}

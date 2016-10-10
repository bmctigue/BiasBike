//
//  CategoriesTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

protocol CategoriesTableViewControllerDelegate: class {
    func doneButtonPressed()
}


class CategoriesTableViewController: UITableViewController {

    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: CategoriesTableViewControllerDelegate?

    private(set) var tableViewDataSource: CategoriesTableViewDataSource?
    private(set) var tableViewDelegate: CategoriesTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset.top = 20
        self.tableView.allowsMultipleSelection = true
        self.tableViewDataSource = CategoriesTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = CategoriesTableViewDelegate(tableView: tableView)
        self.tableView.reloadData()
    }
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        self.tableViewDelegate?.saveSelectedCategories()
        self.delegate?.doneButtonPressed()
        self.dismiss(animated: true, completion:nil)
    }
    

}

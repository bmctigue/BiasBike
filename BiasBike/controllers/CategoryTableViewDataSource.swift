//
//  CategoryTableViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class CategoryTableViewDataSource: NSObject {
    
    private(set) var categoryHash:[String:[Event]] = [:]
    private(set) var category: Category

    init(tableView: UITableView, category: Category) {
        self.category = category
        super.init()
        tableView.dataSource = self
    }
    
    func updateDataSource(categoryHash: [String:[Event]]) {
        self.categoryHash = categoryHash
    }
}

extension CategoryTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let events = self.categoryHash[category.rawValue] {
            return Array(events).count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath as IndexPath) as! EventCell
        return cell
    }
}

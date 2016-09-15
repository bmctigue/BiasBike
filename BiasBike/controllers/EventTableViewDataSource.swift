//
//  EventTableViewDataSource.swift
//  Interview
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventTableViewDataSource: NSObject {
    
    private(set) var categoryHash:[String:[Event]] = [:]
    private(set) var sortedCategories:[CategoryType] = []

    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
    
    func updateDataSource(categoryHash: [String:[Event]]) {
        self.categoryHash = categoryHash
        self.sortedCategories = CategoryController().filteredCategoryTypes(categoryHash: categoryHash)
    }
}

extension EventTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let hash = EventController.sharedInstance.categoryHash()
        return Array(hash.keys).count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = sortedCategories[section]
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

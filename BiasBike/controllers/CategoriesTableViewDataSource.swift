//
//  CategoriesTableViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class CategoriesTableViewDataSource: NSObject {
    
    private(set) var categories:[CategoryType] = []
    private(set) var selectedCategories:[CategoryType] = []

    init(tableView: UITableView) {
        self.categories = CategoryType.categories
        super.init()
        tableView.dataSource = self
    }
}

extension CategoriesTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath as IndexPath)
        return cell
    }
}

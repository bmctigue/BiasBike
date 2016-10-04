//
//  CategoryTableViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallaciesTableViewDataSource: NSObject {
    
    private(set) var fallacies:[Fallacy] = []
    private(set) var selectedFallacies:[Fallacy] = []
    
    init(tableView: UITableView) {
        self.fallacies = FallacyController.sharedInstance.all()
        super.init()
        tableView.dataSource = self
    }
}

extension FallaciesTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fallacies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FallacyCell", for: indexPath as IndexPath)
        return cell
    }
}


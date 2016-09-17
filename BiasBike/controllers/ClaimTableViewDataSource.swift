//
//  ClaimsTableViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ClaimsTableViewDataSource: NSObject {
    
    private(set) var eventId: String
    private(set) var claims:[Claim] = []

    init(tableView: UITableView, eventId: String) {
        self.eventId = eventId
        super.init()
        tableView.dataSource = self
    }
    
    func updateDataSource(claims: [Claim]) {
        self.claims = claims
    }
}

extension ClaimsTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return claims.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ClaimCell = tableView.dequeueReusableCell(withIdentifier: "ClaimCell", for: indexPath as IndexPath) as! ClaimCell
        return cell
    }
}

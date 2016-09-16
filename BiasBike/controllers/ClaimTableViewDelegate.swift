//
//  ClaimsTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ClaimsTableViewDelegate: NSObject {
    
    private(set) var eventId: String
    private(set) var claims:[Claim] = []

    init(tableView: UITableView, eventId: String) {
        self.eventId = eventId
        self.claims = ClaimController.sharedInstance.all(eventId: eventId)
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(eventId: String) {
        self.eventId = eventId
        self.claims = ClaimController.sharedInstance.all(eventId: eventId)
    }
}

extension ClaimsTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:ClaimCell = cell as! ClaimCell
        let claim = claims[indexPath.row]
        cell.updateCell(title: claim.title, probability: claim.probability, aggProbability: claim.aggProbability)
    }
}

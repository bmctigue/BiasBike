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
    private(set) weak var claimsTableViewController: ClaimsTableViewController?

    init(tableView: UITableView, eventId: String, claimsTableViewController: ClaimsTableViewController) {
        self.eventId = eventId
        self.claimsTableViewController = claimsTableViewController
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(claims: [Claim]) {
        self.claims = claims
    }
}

extension ClaimsTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:ClaimCell = cell as! ClaimCell
        let claim = claims[indexPath.row]
        cell.updateCell(title: claim.title, probability: claim.probability, aggProbability: claim.aggProbability)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let claim = claims[indexPath.row]
        let storyboard = UIStoryboard(name: "Modals", bundle: nil)
        let controller: ClaimRatingViewController = storyboard.instantiateViewController(withIdentifier: "ClaimRatingViewController") as! ClaimRatingViewController
        controller.claim = claim
        claimsTableViewController?.present(controller, animated: true, completion: nil)
    }
}

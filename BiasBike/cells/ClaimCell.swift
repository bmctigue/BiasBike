//
//  ClaimCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

protocol ClaimCellDelegate: class {
    func rateButtonPressed(claim: Claim)
}

class ClaimCell: UITableViewCell {
    
    @IBOutlet weak var aggRatingLabel: UILabel!
    
    weak var delegate: ClaimCellDelegate?
    var claim: Claim?
    
    func updateCell(claim: Claim, rating: Int, aggRating: Int) {
        self.claim = claim
        self.textLabel?.text = claim.title
        self.detailTextLabel?.text = "Rating: \(rating)"
        self.aggRatingLabel.text = "\(aggRating)"
        let ratingImageName = CellUtitilities().ratingImageNameString(rating: rating)
        self.imageView?.image = UIImage(named: ratingImageName)
    }
    
    @IBAction func rateButtonPressed(_ sender: AnyObject) {
        delegate?.rateButtonPressed(claim: claim!)
    }
    
}

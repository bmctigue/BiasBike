//
//  ClaimCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ClaimCell: UITableViewCell {
    
    @IBOutlet weak var aggRatingLabel: UILabel!
    
    func updateCell(title: String, rating: Int, aggRating: Int) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = "Rating: \(rating)"
        self.aggRatingLabel.text = "\(aggRating)"
        let ratingImageName = CellUtitilities().ratingImageNameString(rating: rating)
        self.imageView?.image = UIImage(named: ratingImageName)
    }
}

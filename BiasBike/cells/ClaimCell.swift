//
//  ClaimCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ClaimCell: UITableViewCell {
    
    func updateCell(title: String, rating: Int) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = "Rating: \(rating)"
        let ratingImageName = CellUtitilities().ratingImageNameString(rating: rating)
        self.imageView?.image = UIImage(named: ratingImageName)
    }
}

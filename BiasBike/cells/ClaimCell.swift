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
        let ratingImageName = ratingImageNameString(rating: rating)
        self.imageView?.image = UIImage(named: ratingImageName)
    }
    
    func ratingImageNameString(rating: Int) -> String {
        var ratingImageName: String
        if rating <= 25 {
            ratingImageName = "red_10_percent"
        } else if rating <= 50 {
            ratingImageName = "orange_40_percent"
        } else if rating <= 75 {
            ratingImageName = "yellow_70_percent"
        } else {
            ratingImageName = "green_90_percent"
        }
        return ratingImageName
    }
}

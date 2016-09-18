//
//  ClaimCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ClaimCell: UITableViewCell {
    
    func updateCell(title: String, probability: Int, aggProbability: Int) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = "Probablity: \(probability)%"
        let ratingImageName = ratingImageNameString(aggProbability: aggProbability)
        self.imageView?.image = UIImage(named: ratingImageName)
    }
    
    func ratingImageNameString(aggProbability: Int) -> String {
        var ratingImageName: String
        if aggProbability <= 25 {
            ratingImageName = "red_10_percent"
        } else if aggProbability <= 50 {
            ratingImageName = "orange_40_percent"
        } else if aggProbability <= 75 {
            ratingImageName = "yellow_70_percent"
        } else {
            ratingImageName = "green_90_percent"
        }
        return ratingImageName
    }
}

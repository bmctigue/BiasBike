//
//  CellUtilities.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/21/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

enum RatingImage: String {
    case Green = "green_cell_blank"
    case Yellow = "yellow_cell_blank"
    case Orange = "orange_cell_blank"
    case Red = "red_cell_blank"
}

struct CellUtitilities {
    
    func ratingImageNameString(rating: Int) -> String {
        var ratingImageName: String
        if rating <= 25 {
            ratingImageName = RatingImage.Red.rawValue
        } else if rating <= 50 {
            ratingImageName = RatingImage.Orange.rawValue
        } else if rating <= 75 {
            ratingImageName = RatingImage.Yellow.rawValue
        } else {
            ratingImageName = RatingImage.Green.rawValue
        }
        return ratingImageName
    }
}

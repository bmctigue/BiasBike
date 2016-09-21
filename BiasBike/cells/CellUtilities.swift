//
//  CellUtilities.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/21/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

struct CellUtitilities {
    
    func ratingImageNameString(rating: Int) -> String {
        var ratingImageName: String
        if rating <= 25 {
            ratingImageName = "red_cell_blank"
        } else if rating <= 50 {
            ratingImageName = "orange_cell_blank"
        } else if rating <= 75 {
            ratingImageName = "yellow_cell_blank"
        } else {
            ratingImageName = "green_cell_blank"
        }
        return ratingImageName
    }
}


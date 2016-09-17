//
//  ModelControllerUtilities.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol ModelControllerUtilitiesProtocol {
    func saveAllModelControllers()
}

struct ModelControllerUtilities {
    
    func saveAllModelControllers() {
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.save()
        UserController.sharedInstance.save()
    }
}

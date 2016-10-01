//
//  ModelControllerUtilities.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol ModelControllerUtilitiesProtocol {
    func clearAllModelControllers()
    func loadAllModelControllers()
    func saveAllModelControllers()
}

struct ModelControllerUtilities {
    func refreshAppData() {
        clearAllModelControllers()
        loadAllModelControllers()
    }
    
    func clearAllModelControllers() {
        ModelController().clear()
    }
    
    func loadAllModelControllers() {
        UserController.sharedInstance.loadDefault()
        EventController.sharedInstance.loadDefault()
        ClaimController.sharedInstance.loadDefault()
        EvidenceController.sharedInstance.loadDefault()
        FallacyController.sharedInstance.loadDefault()
    }
}

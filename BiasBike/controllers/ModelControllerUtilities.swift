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
        EventController.sharedInstance.clear()
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.clear()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.clear()
        EvidenceController.sharedInstance.save()
        UserController.sharedInstance.clear()
        UserController.sharedInstance.save()
    }
    
    func loadAllModelControllers() {
        EventController.sharedInstance.loadDefault()
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.loadDefault()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.loadDefault()
        EvidenceController.sharedInstance.save()
        UserController.sharedInstance.loadDefault()
        UserController.sharedInstance.save()
    }
    
    func saveAllModelControllers() {
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.save()
        UserController.sharedInstance.save()
    }
}

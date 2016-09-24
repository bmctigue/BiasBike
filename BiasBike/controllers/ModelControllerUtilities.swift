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
        UserController.sharedInstance.clear()
        UserController.sharedInstance.save()
        EventController.sharedInstance.clear()
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.clear()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.clear()
        EvidenceController.sharedInstance.save()
        RatingController.sharedInstance.clear()
        RatingController.sharedInstance.save()
    }
    
    func loadAllModelControllers() {
        UserController.sharedInstance.loadDefault()
        UserController.sharedInstance.save()
        EventController.sharedInstance.loadDefault()
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.loadDefault()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.loadDefault()
        EvidenceController.sharedInstance.save()
        RatingController.sharedInstance.loadDefault()
        RatingController.sharedInstance.save()
    }
    
    func saveAllModelControllers() {
        UserController.sharedInstance.save()
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.save()
        RatingController.sharedInstance.save()
    }
}

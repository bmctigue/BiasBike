//
//  StoryboardFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 11/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardFactoryProtocol {
    func create() -> UIStoryboard
}

struct SplashStoryboardFactory: StoryboardFactoryProtocol {
    func create() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        return storyboard
    }
}

struct MainStoryboardFactory: StoryboardFactoryProtocol {
    func create() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
    }
}

struct ClaimStoryboardFactory: StoryboardFactoryProtocol {
    func create() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Claim", bundle: nil)
        return storyboard
    }
}

struct EvidenceStoryboardFactory: StoryboardFactoryProtocol {
    func create() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Evidence", bundle: nil)
        return storyboard
    }
}

struct FallacyStoryboardFactory: StoryboardFactoryProtocol {
    func create() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Fallacy", bundle: nil)
        return storyboard
    }
}

struct ModalsStoryboardFactory: StoryboardFactoryProtocol {
    func create() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Modals", bundle: nil)
        return storyboard
    }
}

struct RealmSyncLoginStoryboardFactory: StoryboardFactoryProtocol {
    func create() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "RealmSyncLogin", bundle: nil)
        return storyboard
    }
}

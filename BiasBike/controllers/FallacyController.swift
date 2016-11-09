//
//  FallacyController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

final class FallacyController: ModelController {
    
    static let sharedInstance = FallacyController.init()
    
    func all() -> [Fallacy] {
        let items = realm.objects(Fallacy.self)
        if items.count == 0 {
            return [Fallacy]()
        }
        return Array(items)
    }
    
    func all(type: String) -> [Fallacy] {
        let items = all()
        return items.filter{$0.type == type}
    }
    
    func find(key: String) -> Fallacy? {
        return realm.object(ofType: Fallacy.self, forPrimaryKey: key)
    }
    
    func update(item: Fallacy) {
        try! self.realm.write {
            self.realm.add(item, update: true)
        }
    }
    
    func uniqueFallaciesPerEventHash() -> [String:[Fallacy]] {
        var eventFallacyHash: [String:[Fallacy]] = [:]
        var fallacies: [Fallacy]? = []
        let claims = ClaimController.sharedInstance.all()
        let evidenceClaimsHash = EvidenceController.sharedInstance.evidenceClaimsHash()
        for claim in claims {
            var addedFallacies: [String] = []
            fallacies = eventFallacyHash[(claim.event?.eventId)!]
            if fallacies == nil {
                fallacies = []
            }
            let evidenceArray: [Evidence]? = evidenceClaimsHash[claim.claimId]
            if let evidenceArray = evidenceArray {
                for evidence in evidenceArray {
                    let fallacyArray = Array(evidence.fallacies)
                    for fallacy in fallacyArray {
                        if !addedFallacies.contains(fallacy.fallacyId) {
                            fallacies?.append(fallacy)
                            addedFallacies.append(fallacy.fallacyId)
                        }
                    }
                }
            }
            eventFallacyHash[(claim.event?.eventId)!] = fallacies
        }
        return eventFallacyHash
    }
    
    func loadDefault() {
        let fallacyFactory = FallacyFactory()
        let fallacy1 = fallacyFactory.create(title: FallacyType.Anger.title, summary: FallacyType.Anger.summary, example: FallacyType.Anger.example, url: "", icon: FallacyType.Anger.icon, type: FallacyType.Anger.rawValue)
        update(item: fallacy1)
        let fallacy2 = fallacyFactory.create(title: FallacyType.Authority.title, summary: FallacyType.Authority.summary, example: FallacyType.Authority.example, url: "", icon: FallacyType.Authority.icon, type: FallacyType.Authority.rawValue)
        update(item: fallacy2)
        let fallacy3  = fallacyFactory.create(title: FallacyType.Celebrity.title, summary: FallacyType.Celebrity.summary, example: FallacyType.Celebrity.example, url: "", icon: FallacyType.Celebrity.icon, type: FallacyType.Celebrity.rawValue)
        update(item: fallacy3)
        let fallacy4 = fallacyFactory.create(title: FallacyType.CommonBelief.title, summary: FallacyType.CommonBelief.summary, example: FallacyType.CommonBelief.example, url: "", icon: FallacyType.CommonBelief.icon, type: FallacyType.CommonBelief.rawValue)
        update(item: fallacy4)
        let fallacy5 = fallacyFactory.create(title: FallacyType.Desperation.title, summary: FallacyType.Desperation.summary, example: FallacyType.Desperation.example, url: "", icon: FallacyType.Desperation.icon, type: FallacyType.Desperation.rawValue)
        update(item: fallacy5)
        let fallacy6  = fallacyFactory.create(title: FallacyType.Emotion.title, summary: FallacyType.Emotion.summary, example: FallacyType.Emotion.example, url: "", icon: FallacyType.Emotion.icon, type: FallacyType.Emotion.rawValue)
        update(item: fallacy6)
        let fallacy7 = fallacyFactory.create(title: FallacyType.Faith.title, summary: FallacyType.Faith.summary, example: FallacyType.Faith.example, url: "", icon: FallacyType.Faith.icon, type: FallacyType.Faith.rawValue)
        update(item: fallacy7)
        let fallacy8 = fallacyFactory.create(title: FallacyType.Fear.title, summary: FallacyType.Fear.summary, example: FallacyType.Fear.example, url: "", icon: FallacyType.Fear.icon, type: FallacyType.Fear.rawValue)
        update(item: fallacy8)
        let fallacy9  = fallacyFactory.create(title: FallacyType.Heaven.title, summary: FallacyType.Heaven.summary, example: FallacyType.Heaven.example, url: "", icon: FallacyType.Heaven.icon, type: FallacyType.Heaven.rawValue)
        update(item: fallacy9)
        let fallacy10  = fallacyFactory.create(title: FallacyType.Nature.title, summary: FallacyType.Nature.summary, example: FallacyType.Nature.example, url: "", icon: FallacyType.Nature.icon, type: FallacyType.Nature.rawValue)
        update(item: fallacy10)
    }
}

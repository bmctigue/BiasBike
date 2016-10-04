//
//  FallacyType.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

enum FallacyType: String {
    case Anger
    case Authority
    case Celebrity
    case CommonBelief
    case Desperation
    case Emotion
    case Faith
    case Fear
    case Heaven
    case Nature
    
    var title: String {
        switch self {
        case .Anger: return "Appeal to Anger"
        case .Authority: return "Appeal to Authority"
        case .Celebrity: return "Appeal to Celebrity"
        case .CommonBelief: return "Appeal to Common Belief"
        case .Desperation: return "Appeal to Desperation"
        case .Emotion: return "Appeal to Emotion"
        case .Faith: return "Appeal to Faith"
        case .Fear: return "Appeal to Fear"
        case .Heaven: return "Appeal to Heaven"
        case .Nature: return "Appeal to Nature"
        }
    }
    
    var summary: String {
        switch self {
        case .Anger: return "Attacking an opponent's argument on the grounds that it angers you or your audience."
        case .Authority: return "Attempting to support an argument, not offering any direct evidence for the argument, but by appealing to the testimony of an authority."
        case .Celebrity: return "Justifying a belief on the grounds that a celebrity believes it to be true."
        case .CommonBelief: return "Justifying a proposition on the grounds that many people suppose it to be true"
        case .Desperation: return "Demanding that an action be performed to resolve a situation, regardless of whether the proposed action will in fact resolve the situation in question."
        case .Emotion: return "Arguing for the conclusion of an argument by appealing to the emotions of the audience, rather than addressing the matter at hand."
        case .Faith: return "Arguing for a conclusion purely on the basis of faith, rather than invoking any reason or evidence for its truth."
        case .Fear: return "Justifying a conclusion by instilling fear against the alternatives in your audience. Alternatively: justifying a course of action by playing on the audience’s fears."
        case .Heaven: return "Justifying an action on the grounds that it has divine assent, in other words, that God wants you to engage in it."
        case .Nature: return "Grounding the value of something by appealing to its naturalness; in other words, claiming either that something is good because it is natural, or bad because it is unnatural."
        }
    }
    
    var example: String {
        switch self {
        case .Anger: return "Attacking an opponent's argument on the grounds that it angers you or your audience."
        case .Authority: return "Attempting to support an argument, not offering any direct evidence for the argument, but by appealing to the testimony of an authority."
        case .Celebrity: return "Noted actress Astrid McStar said that eating peas gives you cancer. So I'm going to stop eating peas!"
        case .CommonBelief: return "Everybody knows the sun goes around the earth, therefore the sun goes around the earth."
        case .Desperation: return "Something must be done! This is something. We must do this!"
        case .Emotion: return "Reducing welfare payments is cruel. Hence, we should not reduce welfare payments!"
        case .Faith: return "I have faith that the Lord will protect me from cancer. Hence, I have no need to give up smoking."
        case .Fear: return "Either there’s a monster under my bed, or there isn’t. But I would be terrified if there were such a monster! So, best to assume that there isn’t."
        case .Heaven: return "Why did I rob all those banks? Because God told me to!"
        case .Nature: return "Homosexuality is unnatural: the body just isn’t designed for that sort of activity. So it must be wrong!"
        }
    }
    
    var icon: String {
        switch self {
        case .Anger: return "anger"
        case .Authority: return "police"
        case .Celebrity: return "celebrity"
        case .CommonBelief: return "commonbelief"
        case .Desperation: return "desperation"
        case .Emotion: return "emotion"
        case .Faith: return "faith"
        case .Fear: return "fear"
        case .Heaven: return "heaven"
        case .Nature: return "nature"
        }
    }
}

//
//  FallacIcon.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

enum FallacIcons: String {
    case AnonymousAuthority
    case Anger
    case Authority
    
    var title: String {
        switch self {
        case .AnonymousAuthority: return "Anonymous Authority"
        case .Anger: return "Appeal to Anger"
        case .Authority: return "Appeal to Authority"
        }
    }
    
    var summary: String {
        switch self {
        case .AnonymousAuthority: return "An argument's proponent justifies it by appeal to an unidentified authority."
        case .Anger: return "Attacking an opponent's argument on the grounds that it angers you or your audience."
        case .Authority: return "Attempting to support an argument, not offering any direct evidence for the argument, but by appealing to the testimony of an authority."
        }
    }
    
    var example: String {
        switch self {
        case .AnonymousAuthority: return "An argument's proponent justifies it by appeal to an unidentified authority."
        case .Anger: return "Attacking an opponent's argument on the grounds that it angers you or your audience."
        case .Authority: return "Attempting to support an argument, not offering any direct evidence for the argument, but by appealing to the testimony of an authority."
        }
    }
    
    var icon: String {
        switch self {
        case .AnonymousAuthority: return "olderman"
        case .Anger: return "angry"
        case .Authority: return "police"
        }
    }
}

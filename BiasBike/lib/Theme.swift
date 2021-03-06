//
//  Theme.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

enum Theme {
    case Yellow
    case Green
    case Red
    case Orange
    case Track
    case Dark
    case Light
    case Contrast
}

extension Theme {
    var color: UIColor {
        switch self {
        case .Green:
            return UIColor.init(red: 0/255.0, green: 136.0/255.0, blue: 43.0/255.0, alpha: 1.0)
        case .Yellow:
            return UIColor.init(red: 211.0/255.0, green: 177.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        case .Orange:
            return UIColor.init(red: 222.0/255.0, green: 106.0/255.0, blue: 16.0/255.0, alpha: 1.0)
        case .Red:
            return UIColor.init(red: 200.0/255.0, green: 38.0/255.0, blue: 6.0/255.0, alpha: 1.0)
        case .Track:
            return UIColor.init(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor.init(red: 15.0/255.0, green: 74.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor.init(red: 23.0/255.0, green: 115.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        case .Contrast:
            return UIColor.white
        }
    }
}

struct ThemeAppearance {
    func setNavigationBarAppearance(navigationBar: UINavigationBar?) {
        if let navigationBar = navigationBar {
            navigationBar.barTintColor = .white
            navigationBar.tintColor = .black
        }
    }
}

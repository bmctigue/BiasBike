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
    case Dark, Light, Text, Contrast
}

extension Theme {
    var color: UIColor {
        switch self {
        case .Dark:
            return UIColor.init(red: 49.0/255.0, green: 127.0/255.0, blue: 194.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor.init(red: 226.0/255.0, green: 230.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        case .Text:
            return UIColor.init(red: 84.0/255.0, green: 95.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        case .Contrast:
            return .white
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

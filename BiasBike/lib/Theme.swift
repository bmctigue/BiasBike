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
}

extension Theme {
    var color: UIColor {
        switch self {
        case .Yellow:
            return UIColor.init(red: 211.0/255.0, green: 177.0/255.0, blue: 28.0/255.0, alpha: 1.0)
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

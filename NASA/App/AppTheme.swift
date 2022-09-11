//
//  AppTheme.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation
import UIKit

enum Theme {
    case `default`

    // MARK: Internal

    static var textColor: UIColor {
        UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }

    static var backGroundColor: UIColor {
        UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.systemBackground
            } else {
                return UIColor.systemBackground
            }
        }
    }
    
    func apply() {
        switch self {
        case .default:
            defaultTheme()
        }
    }

    // MARK: Private

    private func defaultTheme() {
        // For Theming
    }
}

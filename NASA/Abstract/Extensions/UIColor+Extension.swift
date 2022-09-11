//
//  UIColor+Extension.swift
//  NASA
//
//  Created by Elvis Mwenda on 11/09/2022.
//

import Foundation
import UIKit

extension UIColor {
    static let textGray = hex(0x626262)
    static let lightGray = hex(0xe6e6e6)
    static let background = hex(0xF9F9F9)
    static func hex(_ hex: UInt) -> UIColor {
        return UIColor(red: Double((hex & 0xff0000) >> 16) / 255, green: Double((hex & 0x00ff00) >> 8) / 255, blue: Double(hex & 0x0000ff) / 255, alpha: 1)
    }
}

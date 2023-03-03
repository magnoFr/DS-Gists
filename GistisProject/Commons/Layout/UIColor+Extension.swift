//
//  UIColor+Extension.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init(hex: String, alpha: CGFloat = 1) {
        let cleanHex = hex.replacingOccurrences(of: "#", with: "")

        let scanner = Scanner(string: cleanHex)
        scanner.currentIndex = .init(utf16Offset: 0, in: cleanHex)

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xFF0000) >> 16
        let g = (rgbValue & 0xFF00) >> 8
        let b = (rgbValue & 0xFF)

        self.init(
            red: CGFloat(r) / 0xFF,
            green: CGFloat(g) / 0xFF,
            blue: CGFloat(b) / 0xFF, alpha: alpha
        )
    }
}

//
//  String+Extensions.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 26/02/23.
//

import Foundation
import UIKit

extension String {
    func toColor(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: self, alpha: alpha)
    }
}

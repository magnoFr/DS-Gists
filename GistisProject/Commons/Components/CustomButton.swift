//
//  CustomButtom.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 23/12/20.
//

import Foundation
import UIKit

class CustomButton: UIButton {

//    override var isHighlighted: Bool {
//        didSet {
//            alpha = isHighlighted ? 0.5 : 1
//        }
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isHighlighted = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isHighlighted = false
    }
}

//
//  MFButton.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 26/02/23.
//

import Foundation
import UIKit

final class MFButton: UIButton {
    private var tokens: DesignSystemTokens

    var titleText: String? {
            didSet {
                self.setTitle(titleText, for: .normal)
            }
        }

    override var isHighlighted: Bool {
        didSet {
            let background: UIColor = isHighlighted ? tokens.color.action.highlight.toColor() : tokens.color.action.defualt.toColor()
            backgroundColor = background
        }
    }

    init(tokens: DesignSystemTokens) {
        self.tokens = tokens

        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        clipsToBounds = true
        layer.cornerRadius = CGFloat(tokens.radii.large)

        backgroundColor = tokens.color.action.defualt.toColor()

        titleLabel?.font = UIFont(name: tokens.font.Bold, size: tokens.fontSize.xxl.toCGFloat())

        self.setTitleColor(tokens.color.neutral.light_dark.toColor(), for: .normal)
    }
}

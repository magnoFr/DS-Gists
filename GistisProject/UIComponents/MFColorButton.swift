//
//  MFColorButton.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 25/02/23.
//

import Foundation
import UIKit

final class MFColorButton: UIButton {
    
    private var tokens: DesignSystemTokens

    var titleText: String? {
            didSet {
                self.setTitle(titleText, for: .normal)
            }
        }

    override var isHighlighted: Bool {
        didSet {
            layer.borderColor = isHighlighted ? tokens.color.action.highlight.toColor().cgColor : tokens.color.neutral.light_dark.toColor().cgColor
            if isHighlighted {
                self.setTitleColor(tokens.color.neutral.dark_light.toColor(),for: .highlighted)
            } else {
                self.setTitleColor(tokens.color.neutral.medium.toColor(),for: .normal)
            }
        }
    }
    
    init(tokens: DesignSystemTokens) {
        self.tokens = tokens

        super.init(frame: .zero)

        isHighlighted = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = CGFloat(tokens.radii.medium)
        layer.borderWidth = 1
        clipsToBounds = true

        setImage(UIImage(named: "Ellipse")?.withRenderingMode(.alwaysTemplate), for: .normal)
        setImage(UIImage(named: "Ellipse")?.withRenderingMode(.alwaysTemplate), for: .highlighted)

        imageEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 8)
        titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)

        imageView?.contentMode = .scaleAspectFit

        titleLabel?.font = UIFont(name: tokens.font.medium, size: tokens.fontSize.sm.toCGFloat())
    }
}

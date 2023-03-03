//
//  MFImageView.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 25/02/23.
//

import Foundation
import UIKit

final class MFImageView: UIImageView {
    private var tokens: DesignSystemTokens

    init(tokens: DesignSystemTokens, image: UIImage? = nil) {
        self.tokens = tokens
        super.init(image: image)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = CGFloat(tokens.radii.medium)
        clipsToBounds = true
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension Int {
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

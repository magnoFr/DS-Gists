//
//  FullWidthAutoSizingCollectionViewFlowLayout.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import UIKit

// MARK: - FullWidthAutoSizingCollectionViewFlowLayout

class FullWidthAutoSizingCollectionViewFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Properties

    private var width: CGFloat? {
        return UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.frame.size.width
    }

    // MARK: - Methods

    private func isElementKindItem(representedElementKind: String?) -> Bool {
        return representedElementKind != UICollectionView.elementKindSectionHeader ||
        representedElementKind != UICollectionView.elementKindSectionFooter
    }

    // MARK: - UICollectionViewFlowLayout protocol

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        guard let width = self.width else { return attributes }

        attributes?.forEach { layoutAttribute in
            if isElementKindItem(representedElementKind: layoutAttribute.representedElementKind) {
                layoutAttribute.frame = CGRect(
                    x: .zero,
                    y: layoutAttribute.frame.origin.y,
                    width: width,
                    height: layoutAttribute.frame.size.height
                )
            }
        }

        return attributes
    }
}

//
//  GistiDetailView.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 21/12/20.
//

import Foundation
import UIKit

class GistiDetailView: UIView {

    struct Dimension {
        static let estimatedCellHeight: CGFloat = 300
    }

    // MARK: - Properties

    private(set) lazy var collectionView = buildCollectionView()

    // MARK: - LifeCycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupViewCode()
    }
}

// MARK: - Setup

extension GistiDetailView: ViewCodeConfiguration {

    func setupViewHierarchy() {
        addSubview(collectionView)
    }

    func setupConstraints() {
        collectionView.constraintToSuperview()
    }

    func configureViews() {
        backgroundColor = UIColor(hex: "#F6F2F7")
    }
}

// MARK: - Build views

extension GistiDetailView {
    private func buildCollectionView() -> UICollectionView {
        let layout = FullWidthAutoSizingCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: Dimension.estimatedCellHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(hex: "#F6F2F7")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return collectionView
    }
}

//
//  GistDetailCollectionViewCell.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 21/12/20.
//

import Foundation
import UIKit

protocol GistDetailCardCollectionViewCellProtocol {
    var language: String { get }
    var name: String { get }
}

class GistDetailCardCollectionViewCell: UICollectionViewCell, ReusableIdentifier {

    struct Config: GistDetailCardCollectionViewCellProtocol {
        var language: String
        var name: String
    }
    
    private lazy var cardView = buildCardView()
    private lazy var nameLabel = buildTitleLabel()
    private lazy var LanguageLabel = buildLanguageLabel()
    
    func setup(config: Config) {
        nameLabel.text = config.name
        LanguageLabel.text = config.language
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}

extension GistDetailCardCollectionViewCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        cardView.addSubviews([nameLabel, LanguageLabel])
        contentView.addSubviews([cardView])
    }

    func setupConstraints() {
        cardView
            .topAnchorToSuperview(constant: 24)
            .leadingAnchorToSuperview(constant: 20)
            .trailingAnchorToSuperview(constant: -20)
            .bottomAnchorToSuperview(constant: -8)

        nameLabel
            .topAnchorToSuperview(constant: 24)
            .leadingAnchorToSuperview(constant: 20)
            .bottomAnchorToSuperview(constant: -20)

        LanguageLabel
            .topAnchorToSuperview(constant: 24)
            .leadingAnchor(equalTo: nameLabel.trailingAnchor, constant: 20)
            .trailingAnchorToSuperview(constant: -20)
            .bottomAnchorToSuperview(constant: -20)
    }

    func configureViews() {
        backgroundColor = UIColor(hex: "#F6F2F7")
    }
}

extension GistDetailCardCollectionViewCell {
    func buildTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        label.textColor = .black

        return label
    }

    func buildLanguageLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor(hex: "#7711DD")
        label.numberOfLines = 0
        label.textAlignment = .right

        return label
    }

    func buildCardView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.round(withRadius: 8)

        view.backgroundColor = .white
        view.layer.shadowOffset = .init(width: 0, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3

        return view
    }
}

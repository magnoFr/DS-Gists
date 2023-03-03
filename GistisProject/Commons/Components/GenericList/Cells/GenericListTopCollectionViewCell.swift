//
//  GenericListTopCollectionViewCell.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import UIKit

protocol GenericListTopCollectionViewCellProtocol {
    var showFavorite: Bool { get }
    var title: String { get }
}

protocol GenericListTopCollectionViewCellDelegate: AnyObject {
    func favoriteTapped()
}

class GenericListTopCollectionViewCell: UICollectionViewCell, ReusableIdentifier {

    struct Config: GenericListTopCollectionViewCellProtocol {
        let showFavorite: Bool
        let title: String
    }

    private lazy var title = buildTitleLabel()
    private lazy var favoriteButtom = buildFavoriteButtom()
    weak var delegate: GenericListTopCollectionViewCellDelegate?
    private var config: Config!

    func setup(config: Config) {
        self.config = config
        setupLayout()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
    }

    func setupLayout() {
        favoriteButtom.isHidden = !config.showFavorite
        title.text = config.title
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

extension GenericListTopCollectionViewCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubviews([title, favoriteButtom])
    }

    func setupConstraints() {
        title
            .topAnchorToSuperview(constant: 30)
            .leadingAnchorToSuperview(constant: 20)
            .bottomAnchorToSuperview(constant: -16)

        favoriteButtom
            .topAnchorToSuperview(constant: 30)
            .leadingAnchor(equalTo: title.trailingAnchor, constant: -40)
            .centerYAnchor(equalTo: title.centerYAnchor)
            .trailingAnchorToSuperview(constant: -20)
    }

    func configureViews() {
        backgroundColor = UIColor(hex: "#7711DD")
    }
}

extension GenericListTopCollectionViewCell {
    private func buildTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = UIColor(hex: "#F6F2F7")

        return label
    }

    private func buildFavoriteButtom() -> UIButton {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitleColor(UIColor(hex: "#F6F2F7"), for: .normal)
        button.setTitleColor(UIColor(hex: "#F6F2F7", alpha: 0.5), for: .highlighted)
        button.setTitle("Favoritos", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)

        return button
    }

    @objc private func favoriteTapped(_ button: UIButton) {
        delegate?.favoriteTapped()
    }
}

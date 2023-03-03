//
//  GenericListCardCollectionViewCell.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 21/12/20.
//

import UIKit

protocol GenericListCardCollectionViewCellProtocol {
    var image: String { get }
    var name: String { get }
    var type: String { get }
    var showFavorite: Bool { get }
}

protocol GenericListCardCollectionViewCellDelegate: AnyObject {
    func favoriteIconTapped(view: GenericListCardCollectionViewCell)
}

class GenericListCardCollectionViewCell: UICollectionViewCell, ReusableIdentifier {

    struct Config: GenericListCardCollectionViewCellProtocol {
        var image: String
        var name: String
        var type: String
        var showFavorite: Bool
    }
    
    private lazy var cardView = buildCardView()
    private lazy var iconImage = buildPerfilImage()
    private lazy var userNameLabel = buildTitleLabel()
    private lazy var fileTypeLabel = buildFileTypeLabel()
    private lazy var favoriteButtom =  buildFavoriteButtom()

    weak var delegate: GenericListCardCollectionViewCellDelegate?
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
        iconImage.load(url: config.image)
        userNameLabel.text = config.name
        fileTypeLabel.text = config.type
        favoriteButtom.isChecked = config.showFavorite
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

extension GenericListCardCollectionViewCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        cardView.addSubviews([iconImage, userNameLabel, fileTypeLabel, favoriteButtom])
        contentView.addSubviews([cardView])
    }

    func setupConstraints() {
        cardView
            .topAnchorToSuperview(constant: 24)
            .leadingAnchorToSuperview(constant: 20)
            .trailingAnchorToSuperview(constant: -20)
            .bottomAnchorToSuperview(constant: -8)

        iconImage
            .topAnchorToSuperview(constant: 24)
            .leadingAnchorToSuperview(constant: 20)
            .widthAnchor(equalTo: 64)
            .heightAnchor(equalTo: iconImage.widthAnchor)

        userNameLabel
            .centerYAnchor(equalTo: iconImage.centerYAnchor)
            .leadingAnchor(equalTo: iconImage.trailingAnchor, constant: 32)
            .trailingAnchorToSuperview(constant: -20)

        fileTypeLabel
            .topAnchor(equalTo: iconImage.bottomAnchor, constant: 40)
            .leadingAnchorToSuperview(constant: 24)
            .trailingAnchorToSuperview(constant: -20)
            .bottomAnchorToSuperview(constant: -16)

        favoriteButtom
            .topAnchorToSuperview(constant: 8)
            .trailingAnchorToSuperview(constant: -20)
            .widthAnchor(equalTo: 32)
            .heightAnchor(equalTo: favoriteButtom.widthAnchor)
        
    }

    func configureViews() {
        backgroundColor = UIColor(hex: "#F6F2F7")
    }
}

extension GenericListCardCollectionViewCell {
    func buildTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 0
        label.textColor = .black

        return label
    }

    func buildFileTypeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.textColor = .black

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

    func buildPerfilImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor(hex: "#F6F2F7", alpha: 0.9).cgColor
        imageView.layer.borderWidth = 1.0

        imageView.image = UIImage()

        return imageView
    }

    private func buildFavoriteButtom() -> FavoriteButton {
        let button = FavoriteButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitleColor(UIColor(hex: "#F6F2F7"), for: .normal)
        button.setTitleColor(UIColor(hex: "#F6F2F7", alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)

        return button
    }

    @objc private func favoriteTapped(_ button: FavoriteButton) {
        delegate?.favoriteIconTapped(view: self)
        button.isChecked.toggle()
    }
}

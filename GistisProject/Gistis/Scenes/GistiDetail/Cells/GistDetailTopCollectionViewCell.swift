//
//  GistDetailTopCollectionViewCell.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 24/12/20.
//

import UIKit

protocol GistDetailTopCollectionViewCellProtocol {
    var name: String { get }
    var image: String { get }
    var numberOfItems: String { get }
}

class GistDetailTopCollectionViewCell: UICollectionViewCell, ReusableIdentifier {

    struct Config: GistDetailTopCollectionViewCellProtocol {
        let name: String
        let image: String
        let numberOfItems: String
    }

    private lazy var title = buildTitleLabel()
    private lazy var imageView = buildPerfilImage()
    private lazy var infoLabel = buildInfoLabel()

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
        imageView.load(url: config.image)
        title.text = config.name
        infoLabel.text = config.numberOfItems
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

extension GistDetailTopCollectionViewCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubviews([title, imageView, infoLabel])
    }

    func setupConstraints() {
        imageView
            .topAnchorToSuperview(constant: 30)
            .leadingAnchorToSuperview(constant: 20)
            .heightAnchor(equalTo: 80)
            .widthAnchor(equalTo: imageView.heightAnchor)

        title
            .topAnchorToSuperview(constant: 30)
            .leadingAnchor(equalTo: imageView.trailingAnchor, constant: 40)
            .centerYAnchor(equalTo: imageView.centerYAnchor)
            .trailingAnchorToSuperview(constant: -20)

        infoLabel
            .topAnchor(equalTo: imageView.bottomAnchor, constant: 24)
            .trailingAnchorToSuperview(constant: -20)
            .leadingAnchorToSuperview(constant: 20)
            .bottomAnchorToSuperview(constant: -16)
    }

    func configureViews() {
        backgroundColor = UIColor(hex: "#7711DD")
    }
}

extension GistDetailTopCollectionViewCell {
    private func buildTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = UIColor(hex: "#F6F2F7")

        return label
    }

    private func buildInfoLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor(hex: "#F6F2F7")

        return label
    }

    func buildPerfilImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor(hex: "#F6F2F7", alpha: 0.9).cgColor
        imageView.layer.borderWidth = 1.0

        imageView.image = UIImage()

        return imageView
    }
}

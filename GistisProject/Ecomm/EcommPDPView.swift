//
//  EcommPDPView.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 25/02/23.
//

import Foundation
import UIKit

final class EcommPDPView: UIView {
    private(set) lazy var scrollView: UIScrollView = buildScrollView()
    private(set) lazy var stackContentView: UIStackView = buildStackView(axis: .vertical, spacing: 0)

    private(set) lazy var topContentView: UIView = buildView()
    private(set) lazy var midleContentView: UIView = buildView()
    private(set) lazy var bottomContentView: UIView = buildView()

    // Top
    private(set) lazy var imageView: MFImageView = .init(tokens: tokens)

    // Midle
    /// Vertical
    private(set) lazy var productStackViewV: UIStackView = buildStackView(axis: .vertical, spacing: tokens.space.two.toCGFloat())
    /// Horizontal
    private(set) lazy var productStackViewH: UIStackView = buildStackView(axis: .horizontal, spacing: tokens.space.ten.toCGFloat())

    private(set) lazy var productNameLabel: UILabel = buildLabel(lines: 0)
    private(set) lazy var productSubNameLabel: UILabel = buildLabel(lines: 1)
    private(set) lazy var productPriceLabel: UILabel = buildLabel(lines: 1)

    private(set) lazy var productColorButtonStack: UIStackView = buildStackView(axis: .horizontal, spacing: tokens.space.four.toCGFloat())
    private(set) lazy var productColorLabel: UILabel = buildLabel(lines: 1)
    private(set) lazy var productColorButton: MFColorButton = .init(tokens: tokens)
    private(set) lazy var productColorButton2: MFColorButton = .init(tokens: tokens)
    private(set) lazy var productColorButton3: MFColorButton = .init(tokens: tokens)

    private(set) lazy var detailLabel: UILabel = buildLabel(lines: 1)
    private(set) lazy var detailDescriptionLabel: UILabel = buildLabel(lines: 0)
    
    private(set) lazy var confirmButton: MFButton = .init(tokens: tokens)

    private var tokens: DesignSystemTokens

    init() {
        self.tokens = .make()

        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(tokens: DesignSystemTokens) {
        self.tokens = tokens

        self.imageView.image = .init(named: "backpack")
        self.imageView.contentMode = .scaleAspectFill

        setupViewCode()
    }
}

extension EcommPDPView: ViewCodeConfiguration {
    public func setupViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubviews(bottomContentView, stackContentView)
        
        stackContentView.addArrangedSubviews(topContentView, midleContentView)

        topContentView.addSubview(imageView)

        midleContentView.addSubviews(
            productStackViewH,
            productColorLabel,
            productColorButtonStack,
            detailLabel,
            detailDescriptionLabel,
            confirmButton
        )
        productColorButtonStack.addArrangedSubviews(productColorButton, productColorButton2, productColorButton3)

        productStackViewV.addArrangedSubviews(productNameLabel, productSubNameLabel)
        productStackViewH.addArrangedSubviews(productStackViewV, productPriceLabel)
    }

    public func setupConstraints() {
        scrollView
            .topAnchor(equalTo: layoutMarginsGuide.topAnchor)
            .leadingAnchorToSuperview()
            .trailingAnchorToSuperview()
            .bottomAnchor(equalTo: layoutMarginsGuide.bottomAnchor)

        stackContentView
            .topAnchor(equalTo: scrollView.topAnchor)
            .leadingAnchor(equalTo: scrollView.leadingAnchor)
            .trailingAnchor(equalTo: scrollView.trailingAnchor)
            .bottomAnchor(equalTo: scrollView.bottomAnchor)
            .widthAnchor(equalTo: scrollView.widthAnchor)

        bottomContentView
            .topAnchor(equalTo: midleContentView.topAnchor)
            .leadingAnchor(equalTo: scrollView.leadingAnchor)
            .trailingAnchor(equalTo: scrollView.trailingAnchor)
            .bottomAnchor(equalTo: bottomAnchor)
            .widthAnchor(equalTo: scrollView.widthAnchor)

        setupConstraintTopConatiner()
        setupConstraintMidleConatiner()
    }

    public func configureViews() {
        stackContentView.distribution = .fill
        backgroundColor = .init(hex: tokens.color.neutral.light_dark)
        
        midleContentView.clipsToBounds = true
        midleContentView.layer.cornerRadius = tokens.radii.large.toCGFloat()
        midleContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        midleContentView.backgroundColor = tokens.color.neutral.light.toColor()

        bottomContentView.clipsToBounds = true
        bottomContentView.layer.cornerRadius = tokens.radii.large.toCGFloat()
        bottomContentView.backgroundColor = tokens.color.neutral.light.toColor()
        bottomContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        productNameLabel.text = "Mulberry Clutch"
        productNameLabel.font = UIFont(name: tokens.font.Bold, size: tokens.fontSize.xxl.toCGFloat())
        productNameLabel.textColor = tokens.color.neutral.dark.toColor()

        productSubNameLabel.text = "( With solo loop )"
        productSubNameLabel.font = UIFont(name: tokens.font.medium, size: tokens.fontSize.sm.toCGFloat())
        productSubNameLabel.textColor = tokens.color.neutral.dark_light.toColor()

        productPriceLabel.text = "$799"
        productPriceLabel.font = UIFont(name: tokens.font.medium, size: tokens.fontSize.x2l.toCGFloat())
        productPriceLabel.textColor = tokens.color.core.brand_3.toColor()
        productPriceLabel.textAlignment = .right

        productColorLabel.text = "Colors"
        productColorLabel.font = UIFont(name: tokens.font.semibold, size: tokens.fontSize.lg.toCGFloat())
        productColorLabel.textColor = tokens.color.neutral.dark.toColor()

        productColorButtonStack.distribution = .fillProportionally
        productColorButton.titleText = "Petrol"
        productColorButton.imageView?.tintColor = .gray
        productColorButton.isHighlighted = true
        
        productColorButton2.titleText = "red"
        productColorButton2.imageView?.tintColor = .red
        
        productColorButton3.titleText = "yellow"
        productColorButton3.imageView?.tintColor = .yellow

        detailLabel.text = "Details"
        detailLabel.font = UIFont(name: tokens.font.semibold, size: tokens.fontSize.lg.toCGFloat())
        detailLabel.textColor = tokens.color.neutral.dark.toColor()
        
        detailDescriptionLabel.text = "Call it a treasure chest or a mini portable world, handbags are indispensable in daily life"
        detailDescriptionLabel.font = UIFont(name: tokens.font.regular, size: tokens.fontSize.md.toCGFloat())
        detailDescriptionLabel.textColor = tokens.color.neutral.medium.toColor()

        confirmButton.titleText = "Add to cart"
    }
}

private extension EcommPDPView {
    func setupConstraintTopConatiner() {
        imageView
            .topAnchorToSuperview(constant: tokens.space.two.toCGFloat())
            .leadingAnchorToSuperview(constant: tokens.space.eigth.toCGFloat())
            .trailingAnchorToSuperview(constant: -tokens.space.eigth.toCGFloat())
            .bottomAnchorToSuperview(constant: -tokens.space.three.toCGFloat())
            .heightAnchor(equalTo: 312)
    }

    func setupConstraintMidleConatiner() {
        productStackViewH
            .topAnchorToSuperview(constant: tokens.space.five.toCGFloat())
            .leadingAnchorToSuperview(constant: tokens.space.five.toCGFloat())
            .trailingAnchorToSuperview(constant: -tokens.space.ten.toCGFloat())

        productColorLabel
            .topAnchor(equalTo: productStackViewH.bottomAnchor, constant: tokens.space.five.toCGFloat())
            .leadingAnchorToSuperview(constant: tokens.space.five.toCGFloat())
            .trailingAnchorToSuperview(constant: -tokens.space.five.toCGFloat())

        productColorButtonStack
            .topAnchor(equalTo: productColorLabel.bottomAnchor, constant: tokens.space.two.toCGFloat())
            .leadingAnchorToSuperview(constant: tokens.space.five.toCGFloat())
            .trailingAnchorToSuperview(constant: -tokens.space.five.toCGFloat())
            .heightAnchor(equalTo: tokens.space.ten.toCGFloat())

        detailLabel
            .topAnchor(equalTo: productColorButtonStack.bottomAnchor, constant: tokens.space.five.toCGFloat())
            .leadingAnchorToSuperview(constant: tokens.space.five.toCGFloat())
            .trailingAnchorToSuperview(constant: -tokens.space.five.toCGFloat())

        detailDescriptionLabel
            .topAnchor(equalTo: detailLabel.bottomAnchor, constant: tokens.space.two.toCGFloat())
            .leadingAnchorToSuperview(constant: tokens.space.five.toCGFloat())
            .trailingAnchorToSuperview(constant: -tokens.space.ten.toCGFloat())

        confirmButton
            .topAnchor(equalTo: detailDescriptionLabel.bottomAnchor, constant: tokens.space.six.toCGFloat())
            .leadingAnchorToSuperview(constant: tokens.space.five.toCGFloat())
            .trailingAnchorToSuperview(constant: -tokens.space.five.toCGFloat())
            .bottomAnchorToSuperview(constant: -tokens.space.five.toCGFloat())
            .heightAnchor(equalTo: 72)
        
    }
}

private extension EcommPDPView {
    func buildScrollView() -> UIScrollView {
        let view: UIScrollView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func buildStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let view: UIStackView = .init()
        view.axis = axis
        view.spacing = spacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func buildView() -> UIView {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func buildLabel(lines: Int) -> UILabel {
        let label: UILabel = .init()
        label.numberOfLines = lines
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }
}

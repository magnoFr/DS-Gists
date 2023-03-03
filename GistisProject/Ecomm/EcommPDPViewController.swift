//
//  EcommPDPViewController.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 25/02/23.
//

import Foundation
import UIKit

final class EcommPDPViewController: LoadableViewController<EcommPDPView> {
    // MARK: - Properties
    
    private let viewModel: EcommPDPViewModelProtocol
    
    // MARK: - Init
    
    init(viewModel: EcommPDPViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setup(tokens: viewModel.makeSystemTwo())
    }
}

extension DesignSystemTokens {
    static func make() -> Self {
        return .init(
            space: .init(one: 4, two: 8, three: 12, four: 16, five: 20, six: 24, seven: 28, eigth: 32, nine: 36, ten: 40),
            radii: .init(sharp: 0, small: 4, medium: 8, large: 16, pill: 32),
            color: .init(
                core: .init(
                    brand_1: "#E5F3FF",
                    brand_2: "#0086FF",
                    brand_3: "#000077"
                ),
                action: .init(
                    defualt: "#1992FF",
                    highlight: "0D8BFD"
                ),
                neutral: .init(
                    dark: "#515151",
                    dark_light: "#9B9B9B",
                    medium: "#AEAEAE",
                    medium_light: "#C6C6C6",
                    light: "#FFFFFF",
                    light_dark: "#F2F2F2"
                )
            ),
            fontSize: .init(
                xxs: 8,
                xs: 10,
                sm: 12,
                md: 14,
                lg: 16,
                xl: 18,
                xxl: 20,
                x2l: 24,
                x3l: 36
            ),
            font: .init(
                thin: "Raleway-Thin",
                regular: "Raleway-Regular",
                medium: "Raleway-Medium",
                semibold: "Raleway-SemiBold",
                Bold: "Raleway-Bold"
            )
        )
    }
}

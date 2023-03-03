//
//  EcommCoordinator.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 25/02/23.
//

import Foundation
import UIKit

final class EcommCoordinator: Coordinator {
    private let topViewController: UIViewController
    private let navigationController = UINavigationController()

    private var delegate: CommonsCoordinatorDelegate?

    public init(topViewController: UIViewController, delegate: CommonsCoordinatorDelegate) {
        self.topViewController = topViewController
        self.delegate = delegate
    }

    public override func start() {
        let viewModel = EcommPDPViewModel()
        let controller = EcommPDPViewController(viewModel: viewModel)
        navigationController.viewControllers = [controller]
        navigationController.modalPresentationStyle = .fullScreen
        topViewController.present(navigationController, animated: true)
    }
}

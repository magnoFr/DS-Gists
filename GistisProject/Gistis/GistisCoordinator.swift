//
//  GistisCoordinatir.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import UIKit

public protocol GistisCoordinatorDelegate: AnyObject {
    // Protocol to GistisCoordinator communicates with your parent's Coordinator
}

// MARK: - Class GistisCoordinator

public class GistisCoordinator: Coordinator {

    // MARK: - Properties

    private let topViewController: UIViewController
    private let navigationController = UINavigationController()

    private var delegate: CommonsCoordinatorDelegate?

    // MARK: - Coordinator

    public init(topViewController: UIViewController, delegate: CommonsCoordinatorDelegate) {
        self.topViewController = topViewController
        self.delegate = delegate
    }

    public override func start() {
        let viewModel = GistisListViewModel(delegateCoordinator: self)
        let controller = GenericListViewController(viewModel: viewModel)
        navigationController.viewControllers = [controller]
        navigationController.modalPresentationStyle = .fullScreen
        topViewController.present(navigationController, animated: true)
    }

    func startGistiDetail(data: GistListDataModel) {
        let coordinator = GistiDetailCoordinator(navigationController: navigationController, delegate: self, data: data)
        addChildCoordinator(coordinator)

        coordinator.start()
    }

    func startFavorites() {
        let coordinator = GistisFavoriteCoordinator(navigationController: navigationController, delegate: self)
        addChildCoordinator(coordinator)

        coordinator.start()
    }

    public override func finish() {
        removeAllChildCoordinators()
        delegate?.didFinish(from: self)
    }
}

extension GistisCoordinator: GistisListViewModelCoordinatorDelegate {
    func itemTapped(data: GistListDataModel) {
        startGistiDetail(data: data)
    }

    func favoriteTapped() {
        startFavorites()
    }
}

extension GistisCoordinator: GistiDetailCoordinatorDelegate {}
extension GistisCoordinator: GistisFavoriteCoordinatorDelegate {}

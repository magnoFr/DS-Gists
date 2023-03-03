//
//  GistisFavoriteCoordinator.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 23/12/20.
//

import Foundation
import UIKit
import WebKit

public protocol GistisFavoriteCoordinatorDelegate: AnyObject {
    // Protocol to GistisCoordinator communicates with your parent's Coordinator
}

// MARK: - Class GistisCoordinator

class GistisFavoriteCoordinator: Coordinator {

    // MARK: - Properties
    private let navigationController: UINavigationController
    private var delegate: GistisFavoriteCoordinatorDelegate?

    // MARK: - Coordinator

    init(navigationController: UINavigationController, delegate: GistisFavoriteCoordinatorDelegate & Coordinator) {
        self.navigationController = navigationController
        self.delegate = delegate
        super.init()
        self.parentCoordinator = delegate
    }

    override func start() {
        let viewModel = GistisFavoriteViewModel(delegateCoordinator: self)
        let controller = GenericListViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }

    func startGistiDetail(data: GistListDataModel) {
        let coordinator = GistiDetailCoordinator(navigationController: navigationController, delegate: self, data: data)
        addChildCoordinator(coordinator)

        coordinator.start()
    }

    func startWeb(request: URLRequest) {
        let web = WKWebView.init(frame: UIScreen.main.bounds)
        web.load(request)

        let controller = UIViewController()
        controller.view.addSubview(web)
        navigationController.present(controller,animated: true)
    }
}

extension GistisFavoriteCoordinator: GistisFavoriteViewModelCoordinatorDelegate {
    func itemTapped(data: GistListDataModel) {
        startGistiDetail(data: data)
    }
}

extension GistisFavoriteCoordinator: GistiDetailCoordinatorDelegate {}

//
//  RootCoordinator+Flow.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import UIKit

extension RootCoordinator {
    func start(_ flow: FlowType) {
        switch flow {
        case .gistisList:
            showGistisListScreen()
            return
        case .ecomm:
            showEcommScreen()
            return
        }
    }
}

extension RootCoordinator {
    func showGistisListScreen() {
        guard let topController = topController else { return }
        GistisManager.shared.configure(with: GistsConfiguration())
        let coordinator = GistisCoordinator(topViewController: topController, delegate: CommonsCoordinatorDelegateImplementation())
        RootCoordinator.shared.childCoordinators.append(coordinator)
        coordinator.start()
    }

    func showEcommScreen() {
        guard let topController = topController else { return }
        GistisManager.shared.configure(with: GistsConfiguration())
        let coordinator = EcommCoordinator(topViewController: topController, delegate: CommonsCoordinatorDelegateImplementation())
        RootCoordinator.shared.childCoordinators.append(coordinator)
        coordinator.start()
    }
}

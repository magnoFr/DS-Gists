//
//  CommonsCoordinatorDelegateImplementation.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation

public protocol CommonsCoordinatorDelegate: AnyObject {
    func didFinish(from: Coordinator)
    func openFlow(_ flow: FlowType)
}

public extension CommonsCoordinatorDelegate {
    func openFlow(_ flow: FlowType) { }
}

class CommonsCoordinatorDelegateImplementation: CommonsCoordinatorDelegate {
    func didFinish(from: Coordinator) {
        RootCoordinator.shared.childCoordinators.removeAll(where: { $0 == from })
    }

    func openFlow(_ flow: FlowType) {
        RootCoordinator.shared.start(flow)
    }
}

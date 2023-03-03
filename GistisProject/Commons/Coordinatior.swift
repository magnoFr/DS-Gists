//
//  Coordinatior.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation

open class Coordinator {

    public weak var parentCoordinator: Coordinator?
    public private(set) var childCoordinators: [Coordinator] = []

    public init() {}

    open func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    open func finish() {
        guard let parentCoordinator = parentCoordinator else {
            preconditionFailure("ParentCoordinator must be not equal to nil or this method needs to be overriden by a concrete subclass.")
        }
        removeAllChildCoordinators()
        parentCoordinator.removeChildCoordinator(self)
    }

    open func finishParent() {
        guard let parentCoordinator = parentCoordinator else {
            preconditionFailure("ParentCoordinator must be not equal to nil or this method needs to be overriden by a concrete subclass.")
        }
        parentCoordinator.finish()
    }

    public func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    public func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.lastIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }

    public func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }

    public func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

}

extension Coordinator: Equatable {
    public static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}

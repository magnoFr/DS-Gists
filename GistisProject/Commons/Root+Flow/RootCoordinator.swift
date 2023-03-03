//
//  RootCoordinator.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import UIKit

class RootCoordinator {

    private init() {}

    // MARK: - Properties
    var window: UIWindow!

    // MARK: - Coordinator Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()

    static var shared = RootCoordinator()

    internal var topController: UIViewController? {
        return UIApplication.topViewController()
    }

    // MARK: - Constructors
    func setup(window: UIWindow) {
        self.window = window
    }
}

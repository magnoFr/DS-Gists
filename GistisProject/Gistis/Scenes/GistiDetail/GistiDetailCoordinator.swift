//
//  GistiDetailCoordinator.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 21/12/20.
//

import Foundation
import UIKit
import WebKit

public protocol GistiDetailCoordinatorDelegate: AnyObject {
    // Protocol to GistisCoordinator communicates with your parent's Coordinator
}

// MARK: - Class GistisCoordinator

class GistiDetailCoordinator: Coordinator {

    // MARK: - Properties
    private let navigationController: UINavigationController
    private var delegate: GistiDetailCoordinatorDelegate?
    private var data: GistListDataModel

    // MARK: - Coordinator

    init(navigationController: UINavigationController, delegate: GistiDetailCoordinatorDelegate & Coordinator, data: GistListDataModel) {
        self.navigationController = navigationController
        self.delegate = delegate
        self.data = data
        super.init()
        self.parentCoordinator = delegate
    }

    override func start() {
        let viewModel = GistiDetailViewModel(delegateCoordinator: self, data: data)
        let controller = GistiDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }

    func startWeb(request: URLRequest) {
        let web = WKWebView.init(frame: UIScreen.main.bounds)
        web.load(request)

        let controller = UIViewController()
        controller.view.addSubview(web)
        navigationController.present(controller,animated: true)
    }
}

extension GistiDetailCoordinator: GistiDetailViewModelCoordinatorDelegate {
    func itemTapped(url: URLRequest) {
        startWeb(request: url)
    }
    
    func backTapped() {
        navigationController.popViewController(animated: true)
        finish()
    }
}

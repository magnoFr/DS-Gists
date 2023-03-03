//
//  GistisFavoriteViewModel.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 23/12/20.
//

import Foundation
import UIKit

protocol GistisFavoriteViewModelProtocol: GenericListViewModelProtocol {
    init(delegateCoordinator: GistisFavoriteViewModelCoordinatorDelegate?)
}

protocol GistisFavoriteViewModelCoordinatorDelegate: AnyObject {
    func itemTapped(data: GistListDataModel)
}

// MARK: - Enums

enum GistisFavoriteState {
    case `default`
//    case loading
//    case success
//    case failure(message: String)
}

// MARK: - Class

class GistisFavoriteViewModel {

    // MARK: - Enums and Protocols

    enum Section: Int, CaseIterable {
        case header
        case card
    }

    enum Constant {
        static let numberOfSections: Int = 3
    }

    // MARK: - Properties
    private var state: Observable<GistisListState>
    private var data: [GistListDataModel]?
    private var worker: GistisListWorker
    private weak var delegateCoordinator: GistisFavoriteViewModelCoordinatorDelegate?

    // MARK: - LoanDetailViewModelProtocol init

    required init(delegateCoordinator: GistisFavoriteViewModelCoordinatorDelegate?) {
        self.delegateCoordinator = delegateCoordinator
        self.state = Observable<GistisListState>(.default)
        self.worker = .init()
    }
}

// MARK: - GistiDetailViewModelProtocol

extension GistisFavoriteViewModel: GistisFavoriteViewModelProtocol {

    func section(for index: Int) -> GistisListViewModel.Section? {
        guard let section = GistisListViewModel.Section(rawValue: index) else { return nil }
        return section
    }
    
    func observeStates(_ completion: @escaping (GistisListState) -> Void) {
        self.state.observe { completion($0) }
    }

    var numberOfSections: Int {
        return Constant.numberOfSections
    }

    func numberOfItems(at section: Int) -> Int {
        guard let sectionType = self.section(for: section) else { return 0 }
        switch sectionType {
        case .header:
            return 1
        case .card:
            return data?.count ?? 0
        }
    }

    func topCardConfig() -> GenericListTopCollectionViewCellProtocol {
        let card = GenericListTopCollectionViewCell.Config(
            showFavorite: false,
            title: "Favoritos")

        return card
    }

    func card(row: Int) -> GenericListCardCollectionViewCellProtocol {
        let card = GenericListCardCollectionViewCell.Config(
            image: data?[row].owner?.avatar ?? "",
            name: data?[row].owner?.login ?? "",
            type: data?[row].typeName ?? "",
            showFavorite: showFavorits(gist: data?[row]))

        return card
    }

    func favoriteIconTapped(index: Int) {
        if let data = data?[index] {
            if showFavorits(gist: data) {
                GistisManager.shared.removeGist(gist: data)
            } else {
                GistisManager.shared.saveGists(gists: [data])
            }
        }
    }

    func itemTapped(row: Int) {
        guard let item = data?[row] else { return }
        delegateCoordinator?.itemTapped(data: item)
    }

    func getList() {
        self.data = GistisManager.config.favoriteGists
    }

    private func showFavorits(gist: GistListDataModel?) -> Bool{
        guard let gist = gist else { return false }
        return GistisManager.config.favoriteGists.contains(where: {$0.id == gist.id})
    }
}

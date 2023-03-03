//
//  GistisListViewModel.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation

protocol GistisListViewModelProtocol: GenericListViewModelProtocol {
    init(delegateCoordinator: GistisListViewModelCoordinatorDelegate?)
}

protocol GistisListViewModelCoordinatorDelegate: AnyObject {
    func itemTapped(data: GistListDataModel)
    func favoriteTapped()
}

// MARK: - Enums

enum GistisListState {
    case `default`
    case success
    case failure(message: String)
}

// MARK: - Class

class GistisListViewModel {

    // MARK: - Enums and Protocols

    enum Section: Int, CaseIterable {
        case header
        case card
    }

    enum Constant {
        static let numberOfSections: Int = 2
    }

    // MARK: - Properties

    private var state: Observable<GistisListState>
    private var data: [GistListDataModel]?
    private var worker: GistisListWorker
    private weak var delegateCoordinator: GistisListViewModelCoordinatorDelegate?

    private var isWating: Bool = false
    private var pageNumber: Int = 1

    // MARK: - LoanDetailViewModelProtocol init

    required init(delegateCoordinator: GistisListViewModelCoordinatorDelegate?) {
        self.delegateCoordinator = delegateCoordinator
        self.state = Observable<GistisListState>(.default)
        self.worker = .init()
    }
}

// MARK: - GistisListViewModelProtocol

extension GistisListViewModel: GistisListViewModelProtocol {
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

    func section(for index: Int) -> Section? {
        guard let section = Section(rawValue: index) else { return nil }
        return section
    }

    func topCardConfig() -> GenericListTopCollectionViewCellProtocol {
        let card = GenericListTopCollectionViewCell.Config(
            showFavorite: true,
            title: "Gists")

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

    func itemTapped(row: Int) {
        guard let item = data?[row] else { return }
        delegateCoordinator?.itemTapped(data: item)
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

    func favoriteTapped() {
        delegateCoordinator?.favoriteTapped()
    }

    func getList() {
        worker.getList(page: 1) { result in
            switch result {
            case let .success(data):
                self.data = data
                self.state.notify(.success)
            case let .failure(error):
                self.state.notify(.failure(message: error.localizedDescription))
            }
        }
    }

    func getListByPage(index: Int) {
        guard let count = data?.count else { return }
        if index == count - 2 && !isWating {
            isWating = true
            self.pageNumber += 1

            worker.getList(page: pageNumber) { result in
                switch result {
                case let .success(data):
                    self.isWating = false
                    self.data?.append(contentsOf: data)
                    self.state.notify(.success)
                case let .failure(error):
                    self.state.notify(.failure(message: error.localizedDescription))
                }
            }
        }
    }

    private func showFavorits(gist: GistListDataModel?) -> Bool{
        guard let gist = gist else { return false }
        return GistisManager.config.favoriteGists.contains(where: {$0.id == gist.id})
    }
}

extension GistListDataModel {
    var typeName: String {
        var typeName = ""

        fileList.forEach { data in
            typeName += "\(data.type ?? "") "
        }

        return typeName
    }
}

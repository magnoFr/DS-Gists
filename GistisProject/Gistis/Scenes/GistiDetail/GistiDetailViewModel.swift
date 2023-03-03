//
//  GistiDetailViewModel.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 21/12/20.
//

import Foundation
import UIKit

protocol GistiDetailViewModelProtocol: AnyObject {
    //var limitConfig: LoanDetailHighlightCollectionViewCellProtocol? { get }
    var numberOfSections: Int { get }

    init(delegateCoordinator: GistiDetailViewModelCoordinatorDelegate?, data: GistListDataModel)

    func observeStates(_ completion: @escaping (GistiDetailState) -> Void)
    func backTapped()
    func section(for index: Int) -> GistiDetailViewModel.Section?
    func numberOfItems(at section: Int) -> Int
    func topCardConfig() -> GistDetailTopCollectionViewCellProtocol
    func card(row: Int) -> GistDetailCardCollectionViewCellProtocol
    func itemTapped(row: Int)
}

protocol GistiDetailViewModelCoordinatorDelegate: AnyObject {
    func backTapped()
    func itemTapped(url: URLRequest)
}

// MARK: - Enums

enum GistiDetailState {
    case `default`
//    case loading
//    case success
//    case failure(message: String)
}

// MARK: - Class

class GistiDetailViewModel {

    // MARK: - Enums and Protocols

    enum Section: Int, CaseIterable {
        case header
        case card
    }

    enum Constant {
        static let numberOfSections: Int = 3
    }

    // MARK: - Properties

    private var state: Observable<GistiDetailState>
    private var data: GistListDataModel
    private var worker: GistisListWorker
    private weak var delegateCoordinator: GistiDetailViewModelCoordinatorDelegate?

    // MARK: - LoanDetailViewModelProtocol init

    required init(delegateCoordinator: GistiDetailViewModelCoordinatorDelegate?, data: GistListDataModel) {
        self.delegateCoordinator = delegateCoordinator
        self.state = Observable<GistiDetailState>(.default)
        self.data = data
        self.worker = .init()
    }
}

// MARK: - GistiDetailViewModelProtocol

extension GistiDetailViewModel: GistiDetailViewModelProtocol {
    func observeStates(_ completion: @escaping (GistiDetailState) -> Void) {
        self.state.observe { completion($0) }
    }

    var numberOfSections: Int {
        return Constant.numberOfSections
    }

    func backTapped() {
        delegateCoordinator?.backTapped()
    }

    func numberOfItems(at section: Int) -> Int {
        guard let sectionType = self.section(for: section) else { return 0 }
        switch sectionType {
        case .header:
            return 1
        case .card:
            return data.fileList.count
        }
    }

    func section(for index: Int) -> Section? {
        guard let section = Section(rawValue: index) else { return nil }
        return section
    }

    func topCardConfig() -> GistDetailTopCollectionViewCellProtocol {
        let card = GistDetailTopCollectionViewCell.Config(
            name: data.owner?.login ?? "",
            image: data.owner?.avatar ?? "",
            numberOfItems: "Arquivos: \(data.files?.count ?? 0)")

        return card
    }

    func card(row: Int) -> GistDetailCardCollectionViewCellProtocol {
        let card = GistDetailCardCollectionViewCell.Config(
            language: data.fileList[row].language ?? "",
            name: data.fileList[row].filename ?? "")

        return card
    }

    func itemTapped(row: Int) {
        guard let urlString = data.fileList[row].url, let url = URL.init(string: urlString) else { return }
        let request = URLRequest(url: url)
        delegateCoordinator?.itemTapped(url: request)
    }
}

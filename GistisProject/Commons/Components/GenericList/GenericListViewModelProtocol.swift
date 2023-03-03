//
//  GenericListViewModelProtocol.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 24/12/20.
//

import Foundation

protocol GenericListViewModelProtocol: AnyObject {
    //var limitConfig: LoanDetailHighlightCollectionViewCellProtocol? { get }
    var numberOfSections: Int { get }

    func observeStates(_ completion: @escaping (GistisListState) -> Void)
    func section(for index: Int) -> GistisListViewModel.Section?
    func numberOfItems(at section: Int) -> Int
    func topCardConfig() -> GenericListTopCollectionViewCellProtocol
    func card(row: Int) -> GenericListCardCollectionViewCellProtocol
    func itemTapped(row: Int)
    func favoriteTapped()
    func favoriteIconTapped(index: Int)
    func getList()
    func getListByPage(index: Int)
}

extension GenericListViewModelProtocol {
    func favoriteTapped() {}
    func getListByPage(index: Int) {}
}

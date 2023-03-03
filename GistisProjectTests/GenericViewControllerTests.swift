//
//  GenericViewControllerTests.swift
//  GistisProjectTests
//
//  Created by Magno Augusto Ferreira Ruivo on 24/12/20.
//

import XCTest
@testable import GistisProject

class GenericListViewModelMock: GenericListViewModelProtocol {
    private var state: Observable<GistisListState>

    init() {
        self.state = Observable<GistisListState>(.default)
    }

    var numberOfSections: Int {
        return 2
    }

    func observeStates(_ completion: @escaping (GistisListState) -> Void) {
        self.state.observe { completion($0) }
    }

    func section(for index: Int) -> GistisListViewModel.Section? {
        nil
    }

    func numberOfItems(at section: Int) -> Int {
        1
    }

    func topCardConfig() -> GenericListTopCollectionViewCellProtocol {
        GenericListTopCollectionViewCell.Config(showFavorite: false, title: "test")
    }

    func card(row: Int) -> GenericListCardCollectionViewCellProtocol {
        GenericListCardCollectionViewCell.Config(image: "", name: "test", type: "test/test", showFavorite: false)
    }

    func itemTapped(row: Int) {}

    func favoriteIconTapped(index: Int) {}

    func getList() {
        
    }
}

class GenericViewControllerTests: XCTestCase {

    var genericListViewModelMock: GenericListViewModelMock!
    var vc: GenericListViewController!

    override func setUp() {
        super.setUp()
        genericListViewModelMock = .init()
        vc = GenericListViewController(viewModel: genericListViewModelMock)
    }

    override func tearDown() {
        super.tearDown()
    }


    func testElements() throws {
        XCTAssertNil(genericListViewModelMock.section(for: 0))
        XCTAssertEqual(genericListViewModelMock.numberOfItems(at: 0), 1)
        XCTAssertEqual(genericListViewModelMock.numberOfSections, 2)
        XCTAssertNotNil(genericListViewModelMock.topCardConfig() as? GenericListTopCollectionViewCell.Config)
        XCTAssertNotNil(genericListViewModelMock.card(row: 0) as? GenericListCardCollectionViewCell.Config)
        XCTAssertNotNil(genericListViewModelMock.favoriteTapped())
        XCTAssertNotNil(genericListViewModelMock.itemTapped(row: 1))
        XCTAssertNotNil(genericListViewModelMock.favoriteIconTapped(index: 0))
    }

    func testGenericViewController() {
        XCTAssertNotNil(vc)
    }
}

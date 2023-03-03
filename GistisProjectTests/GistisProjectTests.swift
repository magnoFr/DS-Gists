//
//  GistisProjectTests.swift
//  GistisProjectTests
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import XCTest
@testable import GistisProject

struct GistListMock {
    let gistList: GistListDataModel
}

class GistisProjectTests: XCTestCase {

    var storage: DataStorage.Type!
    var gistListMock: GistListMock!

    override func setUp() {
        super.setUp()
        storage = DataStorage.self
        gistListMock = .init(gistList: .init(owner: nil, files: nil, id: "123"))
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDataStorageGetters() {

        if let value = storage.favoriteGists {
            XCTAssertNotNil(value)
        } else {
            XCTAssertNil(storage.favoriteGists)
        }

        let data = storage.gistsData
        if data.count != 0 {
            XCTAssertGreaterThan(data.count, 0, "Valor é maior")
        } else {
            XCTAssertEqual(data.count, 0, "Valor é zero")
        }
    }

    func testDataStorageSetters() {
        XCTAssertNil(gistListMock.gistList.files)
        XCTAssertNil(gistListMock.gistList.owner)
        XCTAssertEqual(gistListMock.gistList.id, "123")

        storage.favoriteGists = [gistListMock.gistList]

        XCTAssertNotNil(storage.favoriteGists?.count)
        XCTAssertGreaterThan(storage.favoriteGists?.count ?? 0, 0)
    }

}

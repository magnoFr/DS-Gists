//
//  GistisConfiguration.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation

class GistsConfiguration: GistisConfig {
    var showFavorites: Bool {
        return true
    }

    var favoriteGists: [GistListDataModel] {
        DataStorage.favoriteGists ?? []
    }
}

//
//  GistisConfig.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation

public protocol GistisConfig {
    var showFavorites: Bool { get }

    var favoriteGists: [GistListDataModel] { get }
}

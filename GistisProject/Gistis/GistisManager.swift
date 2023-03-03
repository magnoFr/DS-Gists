//
//  GistisManager.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation

public protocol GistisManagerProtocol: AnyObject {
    func configure(with config: GistisConfig)

    func saveGists(gists: [GistListDataModel])
    func removeGist(gist: GistListDataModel)
}

/// Comunicate with Financing Module
public class GistisManager {

    // MARK: - Singleton

    /// Use this to interact with InvestmentsManager
    public static var shared: GistisManagerProtocol = GistisManager()

    // MARK: - Properties

    private static var _config: GistisConfig?

    /// Config used for all Investments
    static var config: GistisConfig {
        get {
            if _config == nil { fatalError("Need to set FinancingConfig") }
            return _config!
        }
        set(newConfig) { _config = newConfig }
    }

}

// MARK: - Manager Protocol Extension

extension GistisManager: GistisManagerProtocol {
    public func configure(with config: GistisConfig) {
        GistisManager.config = config
    }

    public func saveGists(gists: [GistListDataModel]) {
        let ids = GistisManager.config.favoriteGists.map { $0.id }
        let filteredGists = gists.filter {
            !ids.contains($0.id)
        }

        if !filteredGists.isEmpty {
            DataStorage.favoriteGists = filteredGists
        }
        
    }

    public func removeGist(gist: GistListDataModel) {
        GistisManager.config.favoriteGists.forEach { object in
            if object.id == gist.id {
                DataStorage.gistsData.forEach { value in
                    if value.gists == DataManager.encodeObject(dataModel: object) {
                        DataManager.delete(data: value)
                    }
                }
            }
        }
    }
}

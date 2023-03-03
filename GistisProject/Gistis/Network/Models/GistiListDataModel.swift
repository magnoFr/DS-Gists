//
//  GistiListDataModel.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 22/12/20.
//

import Foundation

public struct GistListDataModel: Codable {
    let owner: GistiOwner?
    let files: [String: GistiFileDetail]?
    let id: String
}

struct GistiOwner: Codable {
    let avatar: String?
    let login: String?

    enum CodingKeys: String, CodingKey {
        case avatar = "avatar_url"
        case login
    }
}

struct GistiFileDetail: Codable {
    let filename: String?
    let type: String?
    let language: String?
    let url: String?
    let size: Int?

    enum CodingKeys: String, CodingKey {
        case filename
        case type
        case language
        case url = "raw_url"
        case size
    }
}

extension GistListDataModel {
    var fileList: [GistiFileDetail] {
        var fileList = [GistiFileDetail]()
        files?.forEach { data in
            fileList.append(data.value)
        }

        return fileList
    }
}

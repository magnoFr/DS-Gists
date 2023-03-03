//
//  DataStorage.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 24/12/20.
//

import Foundation
import CoreData

class DataStorage {
    static var favoriteGists: [GistListDataModel]? {
        get {
            let datas = DataManager.fetch(requestData: GistList.self)
            var objects: [GistListDataModel]? = []
            datas.forEach { data in
                if let gists = data.gists, let object = DataManager.decodeObject(type: GistListDataModel.self, data: gists) {
                    objects?.append(object)
                }
            }
            return objects
        }

        set(newValues) {
            newValues?.forEach { value in
                let encodedData = try? JSONEncoder().encode(value)
                
                if let encodedData = encodedData {
                    let object = GistList(context: DataManager.managedObjectContext)
                    object.gists = encodedData
                    DataManager.save()
                }
            }
        }
    }

    static var gistsData: [GistList] {
        return DataManager.fetch(requestData: GistList.self)
    }
}

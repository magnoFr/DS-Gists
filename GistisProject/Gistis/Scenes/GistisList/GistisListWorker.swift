//
//  GistisListWorker.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import Alamofire

class GistisListWorker {
    func getList(page: Int, completion: @escaping (Result<[GistListDataModel], AFError>) -> Void) {
        GistisNetworkManager().getList(page: page) { result in
            completion(result)
        }
    }
}

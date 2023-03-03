//
//  GistisNetworkManager.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 22/12/20.
//

import Foundation
import Alamofire

class GistisNetworkManager {

    func getList(page: Int, completion: @escaping (Result<[GistListDataModel], AFError>) -> Void) {
        let request = AF.request(GistisEndPoint.getList(page: page))

        request.responseDecodable(of: [GistListDataModel].self) { data in
            DispatchQueue.main.async {
                completion(data.result)
            }
        }
    }
}

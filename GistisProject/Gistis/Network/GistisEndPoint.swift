//
//  GistisEndPoint.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 22/12/20.
//

import Foundation
import Alamofire

enum GistisEndPoint: APIConfiguration {

    case getList(page: Int)

    var basePath: String {
        return "https://api.github.com/gists/"
    }

    var path: String {
        switch self {
        case .getList:
            return basePath + "public"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getList:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getList:
            return .requestContentAndHeaders(.json, [.acceptType, .contentType])
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getList:
            return nil
        }
    }

    var urlParameters: Parameters? {
        switch self {
        case let .getList(page):
            return ["page": page]
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .getList:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try path.asURL()
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue

        task.headers.forEach { value in
            urlRequest.setValue(task.contentType.rawValue, forHTTPHeaderField: value.rawValue)
        }
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        if let urlParameters = urlParameters {
            let queryParams = urlParameters.map { pair in
                URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string:url.absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }

        return urlRequest
    }
}

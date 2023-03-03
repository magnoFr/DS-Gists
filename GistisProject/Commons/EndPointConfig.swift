//
//  EndPointConfig.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 22/12/20.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

enum HTTPTask {
    case requestContentAndHeaders(ContentType, [HTTPHeaderField])

    var contentType: ContentType {
        switch self {
        case let .requestContentAndHeaders(type, _):
            return type
        }
    }

    var headers: [HTTPHeaderField] {
        switch self {
        case let .requestContentAndHeaders(_, headers):
            return headers
        }
    }
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

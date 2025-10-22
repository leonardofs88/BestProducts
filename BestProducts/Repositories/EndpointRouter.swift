//
//  EndpointRouter.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Foundation

enum EndpointRouter: EndpointProtocol {
    case http(RequestType)
    case https(RequestType)

    var domain: URL? {
        let scheme = switch self {
        case .http:
            "http://"
        case .https:
            "https://"
        }
        return URL(string: "\(scheme)dummyjson.com/")
    }

    var method: String {
        switch self {
        case .http(let type), .https(let type):
            return type.rawValue
        }
    }

    func getURL(for type: Endpoint) -> URLRequest? {
        guard let fullPath = domain?.appendingPathComponent(type.rawValue) else { return nil }
        var request = URLRequest(url: fullPath)
        request.httpMethod = method
        return URLRequest(url: fullPath)
    }

}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

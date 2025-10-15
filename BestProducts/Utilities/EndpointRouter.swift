//
//  EndpointRouter.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Foundation

enum EndpointRouter: String {
    case http = "http://"
    case https = "https://"
    
    var domain: URL? {
        URL(string: "\(self.rawValue)dummyjson.com/")
    }
    
    enum Endpoint: String {
        case products
    }
    
    func getURL(for type: Endpoint) -> URLRequest? {
        guard let fullPath = domain?.appendingPathComponent(type.rawValue) else { return nil }
        return URLRequest(url: fullPath)
    }
}

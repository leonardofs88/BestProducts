//
//  MockEndpointRouter.swift
//  BestProducts
//
//  Created by Leonardo Soares on 20/10/2025.
//

import Foundation

enum MockEndpointRouter: EndpointProtocol {
    case file

    var domain: URL? {
        Bundle.main.bundleURL
    }

    func getURL(for type: Endpoint) -> URLRequest? {
        guard let domain else { return nil }
        return URLRequest(url: domain.appendingPathComponent(type.rawValue, conformingTo: .json))
    }
}

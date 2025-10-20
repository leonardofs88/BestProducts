//
//  EndpointProtocol.swift
//  BestProducts
//
//  Created by Leonardo Soares on 20/10/2025.
//

import Foundation

protocol EndpointProtocol {
    var domain: URL? { get }
    func getURL(for type: Endpoint) -> URLRequest?
}

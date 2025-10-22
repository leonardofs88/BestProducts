//
//  MockService.swift
//  BestProducts
//
//  Created by Leonardo Soares on 20/10/2025.
//

import Foundation
import Combine

class MockService: ServiceProtocol {

    let urlSession: URLSession? = nil

    func fetchData(for request: URLRequest) -> AnyPublisher<Data, any Error> {
        Just(request.url)
                    .tryMap { url in
                        guard let url = url else { throw URLError(.fileDoesNotExist) }
                        return try Data(contentsOf: url)
                    }
                    .mapError({ error in
                        print(error.localizedDescription)
                        return error
                    })
                    .eraseToAnyPublisher()
    }
}

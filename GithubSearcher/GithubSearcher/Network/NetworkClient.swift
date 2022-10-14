//
//  NetworkClient.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 14/10/2022.
//

import Foundation
import Combine

final class NetworkClientImpl {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func call<Result: Codable>(endpoint: Endpoint) -> AnyPublisher<Result, Error> {
        session
            .dataTaskPublisher(for: endpoint.url()!)
            .tryMap() { element -> Data in
                guard
                    let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Result.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

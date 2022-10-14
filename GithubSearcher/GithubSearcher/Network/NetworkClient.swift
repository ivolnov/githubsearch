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
    
    func call<Model: Codable>(endpoint: Endpoint) -> AnyPublisher<Result<Model, Error>, Never>  {
        Deferred {
            
            Future { promise in
                
                let url = endpoint.url()!
                
                let dataTask = self.session
                    .dataTask(with: url) { data, response, error in
                        if let error = error {
                            promise(.success(.failure(error)))
                            return
                        }
                        guard
                            let httpResponse = response as? HTTPURLResponse,
                            httpResponse.statusCode == 200
                        else {
                            promise(.success(.failure(URLError(.badServerResponse))))
                            return
                        }
                        
                        guard let data = data else {
                            promise(.success(.failure(URLError(.badServerResponse))))
                            return
                        }
                        
                        do {
                            let model = try self.decoder.decode(Model.self, from: data)
                            promise(.success(.success(model)))
                        } catch let error {
                            promise(.success(.failure(error)))
                        }
                    }
                
                dataTask.resume()
            }
        }
        .eraseToAnyPublisher()
    }
}

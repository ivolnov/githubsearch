//
//  Publisher+Result.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 14/10/2022.
//

import Combine

extension Publisher where Failure == Never {
    func mapSuccess<Model>() -> AnyPublisher<Model, Never> where Output == Result<Model, Error> {
        compactMap { result in
            switch result {
            case .success(let model):
                return model
            case .failure:
                return nil
            }
        }
        .eraseToAnyPublisher()
    }
}

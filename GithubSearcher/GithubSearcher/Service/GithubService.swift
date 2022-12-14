//
//  GitHubService.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 12/10/2022.
//

import Foundation
import Combine


protocol GitHubSearchService {
    func repositories(query: String) -> AnyPublisher<Result<GitHubRepositoriesNetworkModel, Error>, Never>
}

final class GitHubSearchServiceImpl {
    
    private let client: NetworkClientImpl
    
    init(client: NetworkClientImpl = .init()) {
        self.client = client
    }    
}

// MARK: - GitHubSearchService

extension GitHubSearchServiceImpl: GitHubSearchService {
    
    func repositories(query: String) -> AnyPublisher<Result<GitHubRepositoriesNetworkModel, Error>, Never> {
        let endpoint = Api.Github.Search.repositories(query: query)
        return client.call(endpoint: endpoint)
    }
}

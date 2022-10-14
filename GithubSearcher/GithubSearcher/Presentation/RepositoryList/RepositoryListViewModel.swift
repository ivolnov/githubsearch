//
//  RepositoryListViewModel.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 13/10/2022.
//

import Foundation
import Combine

final class RepositoryListViewModel: ObservableObject {
    
    private let querySubject: PassthroughSubject<String, Never>
    private var bag: Set<AnyCancellable> = []
    private let service: GitHubSearchService
    
    @Published
    var cells: [RepositoryCellModel] = []
    @Published
    var isLoading = false
    
    init(service: GitHubSearchService = GitHubSearchServiceImpl()) {
        self.querySubject = .init()
        self.service = service
        bind()
    }

    func search(query: String) {
        querySubject.send(query)
    }
    
    private func bind() {
        
        let queries = querySubject
            .filter { query in query.count > 3 }
            .share()
        
        queries
            .map { _ in true }
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &bag)
        
        let repositories = queries
            .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
            .flatMap { [unowned self] query in service.repositories(query: query) }
            .catch { _ in Empty<GitHubRepositoriesNetworkModel, Never>() }
     
        repositories
            .map { _ in false }
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &bag)
        
        repositories
            .map { [unowned self] model in convert(model) }
            .receive(on: RunLoop.main)
            .assign(to: \.cells, on: self)
            .store(in: &bag)
    }
    
    private func convert(_ model: GitHubRepositoriesNetworkModel) -> [RepositoryCellModel] {
        model
            .items?
            .compactMap { model in
                guard
                    let name = model.name,
                    let url = model.html_url else {
                    return nil
                }
                return .init(name: name, url: url)
                
            } ?? []
    }
}

//
//  RepositoryCellModel.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 13/10/2022.
//

import Foundation

struct RepositoryCellModel: Hashable {
    let name: String
    let url: URL
}

// MARK: - Utils

extension RepositoryDetailViewModel {
    
    static func convert(_ cell: RepositoryCellModel) -> RepositoryDetailViewModel {
        RepositoryDetailViewModel(
            name: cell.name,
            url: cell.url
        )
    }
}

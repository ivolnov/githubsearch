//
//  Api.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 14/10/2022.
//

import Foundation

enum Api {
    enum Github {
        enum Search {
            case repositories(query: String)
        }
    }
}

extension Api.Github.Search: Endpoint {
    
    var path: String {
        switch self {
        case .repositories:
            return "https://api.github.com/search/repositories"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .repositories(let query):
            return [
                URLQueryItem(name: "sort", value: "created"),
                URLQueryItem(name: "order", value: "asc"),
                URLQueryItem(name: "q", value: query),
            ]
        }
    }
}

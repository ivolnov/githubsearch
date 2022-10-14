//
//  GitHubRepositoriesNetworkModel.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 13/10/2022.
//

import Foundation

struct GitHubRepositoriesNetworkModel: Codable {
    
    struct Item: Codable {
        let name: String?
        let html_url: URL?
        let description: String?
    }
    
    let items: [Item]?
}

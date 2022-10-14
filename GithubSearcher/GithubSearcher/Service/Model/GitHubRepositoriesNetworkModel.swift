//
//  GitHubRepositoriesNetworkModel.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 13/10/2022.
//

import Foundation

// MARK: - Welcome
struct GitHubRepositoriesNetworkModel: Codable {
    
    // MARK: - Item
    struct Item: Codable {
        let name: String?
        let html_url: URL?
        let description: String?
    }
    let items: [Item]?
}

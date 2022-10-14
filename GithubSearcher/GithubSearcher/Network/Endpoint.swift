//
//  Endpoint.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 14/10/2022.
//

import Foundation

protocol Endpoint {
    var parameters: [URLQueryItem] { get }
    var path: String { get }
}

extension Endpoint {
    func url() -> URL? {
        var endpoint = URLComponents(string: path)
        endpoint?.queryItems = parameters
        let url = endpoint?.url
        return url
    }
}

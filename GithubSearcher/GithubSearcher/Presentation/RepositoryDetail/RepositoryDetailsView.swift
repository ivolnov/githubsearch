//
//  RepositoryDetailsView.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 13/10/2022.
//

import SwiftUI

struct RepositoryDetailViewModel {
    let name: String
    let url: URL
}

struct RepositoryDetailView: View {
    
    let model: RepositoryDetailViewModel?
    
    var body: some View {
        
        switch model {
            
        case .some(let model):
            
            ZStack {
                ProgressView()
                WebView(url: model.url)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(model.name)
                        .fontWeight(.bold)
                }
            }
            
        case .none:
            Color.clear
        }
    }
}

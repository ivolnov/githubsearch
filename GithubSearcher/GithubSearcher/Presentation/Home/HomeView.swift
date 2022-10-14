//
//  HomeView.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 11/10/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchQuery = ""
    
    var body: some View {
        NavigationView {
            RepositoryListView(searchQuery: $searchQuery)
            RepositoryDetailView(model: nil)
        }
        .accentColor(.primary)
        .searchable(
            text: $searchQuery,
            prompt: "Search"
        ) {
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

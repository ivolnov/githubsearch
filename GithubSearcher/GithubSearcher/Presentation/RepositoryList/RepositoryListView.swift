//
//  RepositoryListView.swift
//  GithubSearcher
//
//  Created by Volnov Ivan on 13/10/2022.
//

import SwiftUI

struct RepositoryListView: View {
    
    @StateObject
    private var viewModel = RepositoryListViewModel()
    @State
    private var showProgress = false
    @Binding
    var searchQuery: String
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.cells, id: \.self) { cell in
                    NavigationLink(destination: RepositoryDetailView(model: .convert(cell))) {
                        Text(cell.name)
                    }
                }
            }
            .listStyle(.insetGrouped)
            
            if viewModel.isLoading {
                ZStack {
                    Color(UIColor.systemBackground)
                    ProgressView()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Github")
                    .font(.largeTitle)
            }
        }
        .onChange(of: searchQuery) { query in
            viewModel.search(query: query)

        }
    }
}


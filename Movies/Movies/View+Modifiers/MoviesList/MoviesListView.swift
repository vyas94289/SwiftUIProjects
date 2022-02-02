//
//  MoviesListView.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject var viewModel = MoviesListViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                contentView
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Movies", displayMode: .inline)
            .onAppear {
                if viewModel.movies.isEmpty {
                    viewModel.startSynching()
                }
            }
        }
    }

    var contentView: some View {
        switch viewModel.event {
        case .loading:
            return ProgressView().eraseToAnyView()
        case .updateDataModel:
            return listView.eraseToAnyView()
        case .error(let message, let retryCallback):
            return Text(message).eraseToAnyView()
        }
    }

    var listView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.movies) { movie in
                    ZStack {

                    }
                    
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}

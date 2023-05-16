//
//  MovieCollectionView.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import SwiftUI

struct MovieCollectionView: View {
    
    // Declared variables
    @ObservedObject var viewModel: MovieCollectionViewModel
    @State var searchText: String = ""
    @State var showMovieDetail: Bool = false
    
    var body: some View {
        ScrollViewReader { scroll in
            SearchBar(text: $searchText)
            VStack {
                List(viewModel.movies.filter { searchText.isEmpty ? true : $0.original_title!.contains(searchText) }, id: \.id ) { movieData in
                    Button {
                        showMovieDetail.toggle()
                    } label: {
                        MovieCellView(movie: movieData)
                            .foregroundColor(.black)
                            .onAppear {
                                viewModel.loadMoreContent(movie: movieData)
                            }
                    }
                    
                    NavigationLink(
                        destination: MovieDetailListView(movie: movieData, isFromFavorite: false, viewModel: viewModel),
                        isActive: $showMovieDetail,
                        label: {})
                    .hidden()
                }
                .resignKeyboardOnDragGesture()
            }
        }
    }
    
    var searchResults: [Movies] {
        if searchText.isEmpty {
            return viewModel.movies
        } else {
            return viewModel.movies.filter { movie in
                if let title = movie.original_title,
                   let artist = movie.title {
                    return title.lowercased() == searchText.lowercased() || artist.lowercased() == searchText.lowercased()
                }
                return false
            }
        }
    }
}

struct MovieCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCollectionView(viewModel: MovieCollectionViewModel())
    }
}

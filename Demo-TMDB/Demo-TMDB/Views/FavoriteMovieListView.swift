//
//  FavoriteMovieListView.swift
//  Demo-TMDB
//
//  Created by Dharam-007 on 15/05/23.
//

import Foundation
import SwiftUI


struct FavoriteMovieListView: View {
    
    // Declared variables
    @ObservedObject var viewModel: MovieCollectionViewModel
    @State var searchText: String = ""
    @State var showMovieDetail: Bool = false
    
    var body: some View {
        ScrollViewReader { scroll in
            VStack {
                if viewModel.favoriteMovies.isEmpty {
                    Text("Please add some movies to the favorites")
                        .font(.custom("Avenir-Heavy", size: 20))
                        .padding()
                } else {
                    SearchBar(text: $searchText)
                    List(viewModel.favoriteMovies.removeDuplicateFavorites().filter { searchText.isEmpty ? true : $0.original_title!.contains(searchText) }) { movieData in
                        MovieCellView(movie: movieData)
                            .onAppear {
                                viewModel.loadMoreContent(movie: movieData)
                            }
                            .onTapGesture {
                                showMovieDetail.toggle()
                            }
                        
                        NavigationLink(
                            destination: MovieDetailListView(movie: movieData, isFromFavorite: true, viewModel: viewModel),
                            isActive: $showMovieDetail,
                            label: {})
                    }
                    .resignKeyboardOnDragGesture()
                }
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

struct FavoriteMovieListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMovieListView(viewModel: MovieCollectionViewModel())
    }
}

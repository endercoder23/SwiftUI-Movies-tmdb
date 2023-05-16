//
//  MovieCollectionViewModel.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import Foundation
import Combine
import Alamofire


class MovieCollectionViewModel: ObservableObject {
    
    @Published var movies: [Movies] = []
    @Published var favoriteMovies: [Movies] = []
    @Published var selectedMovieType: MovieTypes = .popular
    var currentPage: Int = 1
    var totalPages: Int = 0
    var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchMoviesType(for: .popular)
        
        $favoriteMovies
            .sink {
            print($0)
        }
        .store(in: &cancellables)
    }
    
    func loadMoreContent(movie: Movies) {
        let thresholdIndex = self.movies.index(self.movies.endIndex, offsetBy: -1)
        if movies[thresholdIndex].id == movie.id, currentPage <= totalPages {
            currentPage += 1
            fetchMoviesType(for: selectedMovieType)
        }
    }
 
    func onChangePickerView(type: MovieTypes) {
        movies = []
        currentPage = 1
        fetchMoviesType(for: type)
    }
    
    
    func fetchMoviesType(for movieType: MovieTypes) {
        switch movieType {
        case .popular:
            fetchMovies(with: .popular(currentPage.description))
        case .topRated:
            fetchMovies(with: .topRated(currentPage.description))
        case .upcoming:
            fetchMovies(with: .upcoming(currentPage.description))
        case .nowPlaying:
            fetchMovies(with: .nowPlaying(currentPage.description))
        }
    }
    
    func fetchMovies(with endPoint: APIEndpoint){
        cancellable =  MoviesAPI.movies(with: endPoint)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: {[weak self]  moviesModel in
                guard let self else {return}
                self.totalPages = moviesModel.total_pages ?? 0
                self.movies.append(contentsOf: moviesModel.results ?? [])
            })
    }
    
}


extension Array where Element == Movies {
    
    func removeDuplicateFavorites() -> [Movies] {
        var code = Set<Int>()
        return self.compactMap { item in
            if code.contains(item.id ?? 0) {
                return nil
            } else {
                code.insert(item.id ?? 0)
                return item
            }
        }
    }
}

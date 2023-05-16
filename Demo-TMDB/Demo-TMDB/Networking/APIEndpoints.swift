//
//  APIEndpoints.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import Alamofire
import Foundation


enum APIEndpoint: Equatable {
    case popular(String)
    case topRated(String)
    case upcoming(String)
    case image(String)
    case nowPlaying(String)

}


extension APIEndpoint: RequestProtocol {
    var base: String {
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming:
            return "https://api.themoviedb.org/3"
        case .image:
            return "https://image.tmdb.org"
        }
    }
    
    var path: String {
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming:
            return "/3/movie"
        case .image:
            return "/t/p/w500"
        }
    }
    
    
    var pathparam: String? {
        switch self {
            
        case .popular:
            return "/popular"
        case .topRated(_):
            return "/top_rated"
        case .upcoming(_):
            return "/upcoming"
        case .image(let posterImage):
            return "\(posterImage)"
        case .nowPlaying(_):
            return "/now_playing"
        }
    }
    
    
    var apikey: String {
        return "fb9ece4fc9d3c5234db2cb2eceb2f125"
    }
    
    

    var method: HTTPMethod {
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming:
            return .get
        case .image:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type" : "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        var queryItems: [URLQueryItem] = []
        let key = URLQueryItem(name: "api_key", value: apikey)
        let language = URLQueryItem(name: "language", value: "en-US")
        let queries = [key, language]
        queries.forEach {
            queryItems.append($0)
        }

        switch self {
        case .nowPlaying(let pageNumber), .popular(let pageNumber), .topRated(let pageNumber),
             .upcoming(let pageNumber):
            let page = URLQueryItem(name: "page", value: pageNumber)
            queryItems.append(page)
            return queryItems
        case .image:
            return nil
        }
    }
    
    var parameters: Parameters? {
        nil
    }
    
    var requestBody: RequestBody {
        nil
    }
}

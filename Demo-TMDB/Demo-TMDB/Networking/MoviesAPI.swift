//
//  MoviesAPI.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import Foundation
import Combine
import Alamofire


enum MoviesAPI {
    static let agent = NetworkManager()
}

extension MoviesAPI {
    
    static func movies(with endPoint: APIEndpoint) -> AnyPublisher<MoviesDataModel, AFError> {
        return agent.get(endPoint: endPoint)
            .eraseToAnyPublisher()
    }
    
    
}

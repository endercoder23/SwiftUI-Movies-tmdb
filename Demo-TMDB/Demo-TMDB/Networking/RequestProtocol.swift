//
//  RequestProtocol.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import Foundation
import Alamofire

typealias RequestBody = [String : Any]?

protocol RequestProtocol {
    
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var pathparam: String? { get }

    /// The HTTP method.
    var method: HTTPMethod { get }

    /// The HTTP headers/
    var headers: HTTPHeaders? { get }
    
    /// request body
    var requestBody: RequestBody { get }

}

extension RequestProtocol {

    var components: URLComponents {
        if var components = URLComponents(string: base) {
            if let paramPath = pathparam {
                    components.path = path + "\(paramPath)"
                }

            if let queryItems = queryItems, !queryItems.isEmpty {
                components.queryItems = queryItems
            }

            return components
        }
        fatalError("Fail to set components!")

    }

}







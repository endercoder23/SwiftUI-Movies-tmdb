//
//  NetworkManager.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import Foundation
import Combine
import UIKit
import Alamofire


struct NetworkManager {

    func get<T: Decodable>(endPoint: APIEndpoint) -> AnyPublisher<T, AFError>{
        return AF.request(endPoint.components.url!, parameters: endPoint.parameters, headers: endPoint.headers)
            .validate()
            .publishDecodable(type: T.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // Post

    func post<T: Codable>(endPoint: APIEndpoint) -> AnyPublisher<T, AFError> {
        
        return AF.request(endPoint.base, method: endPoint.method, parameters: endPoint.parameters, encoding: JSONEncoding.default, headers: endPoint.headers)
                .validate()
                .publishDecodable(type: T.self)
                .value()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    
    func fetchToken<T: Codable>(endPoint: APIEndpoint, params: T) -> AnyPublisher<T, AFError> {
        
        return AF.request(endPoint.base, method: endPoint.method, parameters: params, encoder: JSONParameterEncoder.default, headers: endPoint.headers)
                .validate()
                .publishDecodable(type: T.self)
                .value()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }

    // multipart image upload

    var progressFloat = PassthroughSubject<Float,Never>()

    func uploadPhoto(endpoint: APIEndpoint ,image: UIImage, headers: HTTPHeaders) -> AnyPublisher<[String], AFError> {
        // E.G header
        /*
            let headers: HTTPHeaders = [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(token)"
            ]
         */
            return AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: UUID().uuidString, fileName: "file.jpeg", mimeType: "image/jpg")
            },
                to: endpoint.base, method: endpoint.method , headers: headers)
                .uploadProgress(queue: .main, closure: { progress in
                  //Current upload progress of file
                  self.progressFloat.send(Float(progress.fractionCompleted))
                      })
              .publishDecodable(type: [String].self)
              .value()
              .receive(on: DispatchQueue.main)
              .eraseToAnyPublisher()
            
    }

    // delete

    func delete<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, AFError> {
        return AF.request(endpoint.base, method: endpoint.method, headers: endpoint.headers)
                .validate()
                .publishDecodable(type: T.self)
                .value()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }

    // empty response request

    func emptyReq<T: Codable>(endpoint: APIEndpoint, params: T) -> AnyPublisher<T, AFError> {
        return AF.request(endpoint.base, method: endpoint.method, parameters: params, encoder: JSONParameterEncoder.default, headers: endpoint.headers)
                .validate()
                .publishDecodable(type: T.self, emptyResponseCodes: [200, 204, 205])
                .value()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    
    func emptyReq<T: Codable>(endpoint: APIEndpoint) -> AnyPublisher<T, AFError> {
        return AF.request(endpoint.base, method: endpoint.method, parameters: endpoint.requestBody, encoding: JSONEncoding.default, headers: endpoint.headers)
                .validate()
                .publishDecodable(type: T.self, emptyResponseCodes: [200, 204, 205])
                .value()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}


struct EmptyEntity: Codable, EmptyResponse {
    
    static func emptyValue() -> EmptyEntity {
        return EmptyEntity.init()
    }
    
    // Download PDF
    
    func downloadAgreement(heroID: Int) -> AnyPublisher<URL, AFError> {
        let token = UUID()
        let url = URL(string: "")!
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(token)"
        ]
        let destinationPath: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0];
                let fileURL = documentsURL.appendingPathComponent("Agreement\(heroID).pdf")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
        return AF.download(url, method: .get, headers: headers, to: destinationPath)
            .validate()
            .publishURL()
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
   //
}

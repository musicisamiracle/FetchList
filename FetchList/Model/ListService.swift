//
//  ListService.swift
//  FetchList
//
//  Created by Dane Thomas on 11/6/20.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse(Error?)
    case failedHTTPResponse
    case invalidData
}

protocol ListServiceable {
    func fetchList(completion: @escaping (Result<ListResponse, Error>) -> Void)
}

/**
 The service for providing list items from the API
 */

struct ListService: ListServiceable {
    let session: URLSession
    
    /**
         An asychronous method for retrieving the list items from the API
     - parameters:
            - completion: An escaping closure for handling the result of the API
     */

    func fetchList(completion: @escaping (Result<ListResponse, Error>) -> Void) {
        guard let url = URL(string: Configuration.apiBaseURL.absoluteString + "/hiring.json") else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        let task = self.session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(NetworkError.invalidResponse(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion(.failure(NetworkError.failedHTTPResponse))
                return
            }
            
            guard let data = data,
                  let list = try? JSONDecoder().decode(ListResponse.self, from: data) else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            completion(.success(list))
        }
        
        task.resume()
    }
}

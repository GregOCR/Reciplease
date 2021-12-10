//
//  NetworkManager.swift
//  Reciplease
//
//  Created by Greg on 18/11/2021.
//

import Foundation

class NetworkManager {
    
    enum Error: Swift.Error {
        case unknowError
        case invalidStatusCode
        case noData
        case failedToDecodeData
    }
    
    static let shared = NetworkManager()
    
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.unknowError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      completion(.failure(.invalidStatusCode))
                      return
                  }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch {
                print(error)
                //print(String(data: data, encoding: .utf8))
                completion(.failure(.failedToDecodeData))
                return
            }
        }
        task.resume()
    }
    
    /*
     [
     CodingKeys(
     stringValue: "hits", intValue: nil),
     _JSONKey(stringValue: "Index 1", intValue: 1),
     CodingKeys(stringValue: "recipe", intValue: nil),
     CodingKeys(stringValue: "ingredients", intValue: nil),
     _JSONKey(stringValue: "Index 6", intValue: 6),
     CodingKeys(stringValue: "foodCategory", intValue: nil)
     ]
     */
}

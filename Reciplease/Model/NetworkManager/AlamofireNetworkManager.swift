//
//  AlamofireNetworkManager.swift
//  Reciplease
//
//  Created by Greg on 10/01/2022.
//

import Foundation
import Alamofire

class AlamofireNetworkManager: NetworkManagerProtocol {
    static let shared = AlamofireNetworkManager()
    
    
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        
        AF.request(url)
            .responseDecodable { (dataResponse: DataResponse<T, AFError>) in
             
                switch dataResponse.result {
                case .success(let response):
                    completion(.success(response))
                case .failure:
                    completion(.failure(.unknowError))
                }
            }
        
    }
    
    
}

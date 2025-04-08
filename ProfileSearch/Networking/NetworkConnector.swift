//
//  NetworkConnector.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-08.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case noData
    case decodingFailed
}

// MARK: - NetworkConnector
class NetworkConnector {
    static let shared = NetworkConnector()
    
    private init() {}
    
    func fetch<T: Decodable>(
        from urlString: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}

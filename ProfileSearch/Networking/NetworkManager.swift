//
//  NetworkManager.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

enum NetworkError: Error {
    case userNotFound
    case networkError
    case dataNotFound
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"

    func fetchUserProfile(
        username: String,
        completion: @escaping (Result<UserDetailsModel, NetworkError>) -> Void
    ) {
        let url = URL(string: baseURL + username)!

        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let error = error {
                completion(.failure(.networkError))
                return
            }

            guard let data = data else {
                completion(.failure(.dataNotFound))
                return
            }

            do {
                let user = try JSONDecoder().decode(
                    UserDetailsModel.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }

    func fetchFollowers(
        for user: UserDetailsModel,
        completion: @escaping (Result<[FollowersModel], NetworkError>) -> Void
    ) {
        let urlString = "https://api.github.com/users/\(user.login)/followers"
        fetchData(from: urlString, completion: completion)
    }

    func fetchFollowing(
        for user: UserDetailsModel,
        completion: @escaping (Result<[FollowersModel], NetworkError>) -> Void
    ) {
        let urlString = "https://api.github.com/users/\(user.login)/following"
        fetchData(from: urlString, completion: completion)
    }

    private func fetchData(
        from urlString: String,
        completion: @escaping (Result<[FollowersModel], NetworkError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.networkError))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.networkError))
                return
            }

            guard let data = data else {
                completion(.failure(.dataNotFound))
                return
            }

            do {
                let followers = try JSONDecoder().decode(
                    [FollowersModel].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

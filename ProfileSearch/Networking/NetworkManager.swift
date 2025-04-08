//
//  NetworkManager.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

// MARK: - NetworkManager
class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func fetchUserProfile(
        username: String,
        completion: @escaping (Result<UserDetailsModel, NetworkError>) -> Void
    ) {
        let urlString = "\(baseURL)\(username)"
        NetworkConnector.shared.fetch(from: urlString, completion: completion)
    }
    
    func fetchFollowers(
        for user: UserDetailsModel,
        completion: @escaping (Result<[FollowersModel], NetworkError>) -> Void
    ) {
        let urlString = "\(baseURL)\(user.login)/followers"
        NetworkConnector.shared.fetch(from: urlString, completion: completion)
    }
    
    func fetchFollowing(
        for user: UserDetailsModel,
        completion: @escaping (Result<[FollowersModel], NetworkError>) -> Void
    ) {
        let urlString = "\(baseURL)\(user.login)/following"
        NetworkConnector.shared.fetch(from: urlString, completion: completion)
    }
}

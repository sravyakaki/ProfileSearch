//
//  FollowersViewModel.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

class FollowersViewModel: ObservableObject {
    @Published var followers: [FollowersModel] = []
    @Published var error: String?

    func fetchFollowers(for user: UserDetailsModel) {
        NetworkManager.shared.fetchFollowers(for: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedFollowers):
                    self.followers = fetchedFollowers
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }
}

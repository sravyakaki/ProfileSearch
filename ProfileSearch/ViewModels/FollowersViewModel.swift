//
//  FollowersViewModel.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

// MARK: - FollowersViewModel
class FollowersViewModel: ObservableObject {
    @Published var followers: [UserDetailsModel] = []
    @Published var error: String?
    
    func fetchFollowers(for user: UserDetailsModel) {
        NetworkManager.shared.fetchFollowers(for: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedFollowers):
                    self.loadFullUserProfiles(from: fetchedFollowers)
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }
    
    private func loadFullUserProfiles(from basicFollowers: [FollowersModel]) {
        for follower in basicFollowers {
            NetworkManager.shared.fetchUserProfile(username: follower.login) {
                result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let userDetails):
                        self.followers.append(userDetails)
                    case .failure(let error):
                        self.error = error.localizedDescription
                    }
                }
            }
        }
    }
}

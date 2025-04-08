//
//  FollowingViewModel.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

// MARK: - FollowingViewModel
class FollowingViewModel: ObservableObject {
    @Published var following: [FollowersModel] = []
    @Published var error: String?
    
    func fetchFollowing(for user: UserDetailsModel) {
        NetworkManager.shared.fetchFollowing(for: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedFollowing):
                    self.following = fetchedFollowing
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }
}

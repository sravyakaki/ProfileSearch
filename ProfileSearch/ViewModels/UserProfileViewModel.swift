//
//  UserProfileViewModel.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

// MARK: - UserProfileViewModel
class UserProfileViewModel: ObservableObject {
    @Published var user: UserDetailsModel?
    @Published var error: String?
    
    func fetchUserProfile(
        username: String, completion: @escaping (Bool) -> Void
    ) {
        NetworkManager.shared.fetchUserProfile(username: username) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.user = user
                    self.error = nil
                    completion(true)
                case .failure(let error):
                    self.user = nil
                    self.error = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}

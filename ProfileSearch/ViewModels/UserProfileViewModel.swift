//
//  UserProfileViewModel.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var user: UserDetailsModel?
    @Published var error: String?

    func fetchUserProfile(username: String) {
        NetworkManager.shared.fetchUserProfile(username: username) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.user = user
                    self.error = nil  // Clear previous errors
                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }

    private func handleError(_ error: NetworkError) {
        switch error {
        case .userNotFound:
            self.error =
                "User not found. Please check the username and try again."
        case .networkError:
            self.error = "Network error. Please check your internet connection."
        case .dataNotFound:
            self.error = "No data found for the requested user."
        case .decodingError:
            self.error = "There was an error processing the data."
        }
    }
}

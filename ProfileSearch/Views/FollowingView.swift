//
//  FollowingView.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import SwiftUI

struct FollowingView: View {
    @ObservedObject var viewModel = FollowingViewModel()
    let user: UserDetailsModel
    @State private var selectedUser: UserDetailsModel? = nil

    var body: some View {
        VStack {
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(viewModel.following) { following in
                    Button(action: {
                        fetchUserDetails(for: following.login)
                    }) {
                        HStack {
                            AsyncImage(url: URL(string: following.avatar_url)) {
                                image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                            Text(following.login)
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchFollowing(for: user)
                }
                .navigationTitle("\(user.login)'s Following")
                .navigationDestination(item: $selectedUser) { user in
                    UserDetailsView(user: user)
                }
            }
        }
    }

    private func fetchUserDetails(for username: String) {
        NetworkManager.shared.fetchUserProfile(username: username) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userDetails):
                    self.selectedUser = userDetails
                case .failure(let error):
                    viewModel.error = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    FollowingView(
        user: UserDetailsModel(
            avatar_url: "", id: 1, name: "sravyakaki", bio: "Sravya Kaki",
            followers: 10, following: 20, followers_url: "test1",
            following_url: "test2", login: "test3"))
}

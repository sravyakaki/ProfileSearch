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

    var body: some View {
        VStack {
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(viewModel.following) { following in
                    NavigationLink(
                        destination: UserDetailsView(username: following.login)
                    ) {
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

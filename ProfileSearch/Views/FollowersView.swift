//
//  FollowersView.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//
import SwiftUI

struct FollowersView: View {
    @ObservedObject var viewModel = FollowersViewModel()
    let user: UserDetailsModel

    var body: some View {
        VStack {
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(viewModel.followers) { follower in
                    NavigationLink(
                        destination: UserDetailsView(user: follower)
                    ) {
                        HStack {
                            AsyncImage(url: URL(string: follower.avatar_url)) {
                                image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                            Text(follower.login)
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchFollowers(for: user)
                }
                .navigationTitle("\(user.login)'s Followers")
            }
        }
    }
}

#Preview {
    FollowersView(
        user: UserDetailsModel(
            avatar_url: "", id: 1, name: "sravyakaki", bio: "Sravya Kaki",
            followers: 10, following: 20, followers_url: "test1",
            following_url: "test2", login: "test3"))
}

//
//  UserDetailsView.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import SwiftUI

struct UserDetailsView: View {
    var username: String
    @StateObject private var viewModel = UserProfileViewModel()

    var body: some View {
        VStack {
            if let user = viewModel.user {
                AsyncImage(url: URL(string: user.avatar_url)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                Text("Username: \(username)")
                    .font(.headline)
                    .padding(.top)

                Text("Name: \(user.name ?? "Name unavailable")")
                    .font(.headline)
                    .padding(.top)

                Text("Description: \(user.bio ?? "Bio  unavailable")")
                    .font(.subheadline)
                    .padding(.bottom)

                VStack {
                    HStack {
                        Text("\(user.followers) followers")
                            .font(.body)

                        NavigationLink(destination: FollowersView(user: user)) {
                            Image(systemName: "link.circle.fill")
                                .font(.title)
                                .foregroundColor(.green)
                        }
                    }
                    HStack {
                        Text("\(user.following) following")
                            .font(.body)

                        NavigationLink(destination: FollowingView(user: user)) {
                            Image(systemName: "link.circle.fill")
                                .font(.title)
                                .foregroundColor(.green)
                        }

                    }

                }
            } else if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
            } else {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchUserProfile(username: username)
        }
    }
}

#Preview {
    UserDetailsView(username: "sravyakaki")
}

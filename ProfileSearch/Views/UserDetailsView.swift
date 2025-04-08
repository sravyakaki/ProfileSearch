//
//  UserDetailsView.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import SwiftUI

// MARK: - UserDetailsView
struct UserDetailsView: View {
    let user: UserDetailsModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.avatar_url)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            Text("Username: \(user.login)")
                .font(.headline)
                .padding(.top)
            
            Text("Name: \(user.name ?? "Name unavailable")")
                .font(.headline)
                .padding(.top)
            
            Text("Description: \(user.bio ?? "Bio unavailable")")
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
        }
        .padding()
    }
}

#Preview {
    UserDetailsView(
        user: UserDetailsModel(
            avatar_url: "", id: 1, name: "sravyakaki", bio: "Sravya Kaki",
            followers: 10, following: 20, followers_url: "test1",
            following_url: "test2", login: "test3"))
}

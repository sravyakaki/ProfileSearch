//
//  UserSearchView.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import SwiftUI

// MARK: - UserSearchView
struct UserSearchView: View {
    @State private var searchText = ""
    @State private var path = NavigationPath()
    @StateObject private var viewModel = UserProfileViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Text("Get Started")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Type a GitHub username in the search bar below")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                HStack {
                    TextField("Search with username", text: $searchText)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Button(action: {
                    if !searchText.isEmpty {
                        searchUser(username: searchText)
                    }
                }) {
                    Text("Search")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: UserDetailsModel.self) { user in
                UserDetailsView(user: user)
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "UserNotFound" {
                    UserNotFoundView()
                }
            }
        }
    }
    
    private func searchUser(username: String) {
        viewModel.fetchUserProfile(username: username) { success in
            DispatchQueue.main.async {
                if success, let user = viewModel.user {
                    path.append(user)
                } else {
                    path.append("UserNotFound")
                }
                searchText = ""
            }
        }
    }
}

#Preview {
    UserSearchView()
}

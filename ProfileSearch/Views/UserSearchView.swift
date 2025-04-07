//
//  UserSearchView.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import SwiftUI

struct UserSearchView: View {
    @State private var searchText = ""
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Get started")
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .padding(.bottom)

                Text("Type a GitHub username in the search bar below")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                    .padding(.bottom)

                HStack {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)

                    Button(action: {
                        if !searchText.isEmpty {
                            path.append(searchText)
                            searchText = ""
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                    }
                }
                .padding()

            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { username in
                UserDetailsView(username: username)
            }
        }
    }
}

#Preview {
    UserSearchView()
}

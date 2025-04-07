//
//  UserSearchView.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import SwiftUI

struct UserSearchView: View {
    @State var test = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Get started")
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .padding(.bottom)
                Text("Type a GitHub username in the search bar below")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                HStack {
                    TextField("Search", text: $test)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
                .navigationTitle("GitHub Search")
        }
    }
}

#Preview {
    UserSearchView()
}

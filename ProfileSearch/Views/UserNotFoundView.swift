//
//  UserNotFoundView.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//
import SwiftUI

// MARK: - UserNotFoundView
struct UserNotFoundView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "person.crop.circle.badge.xmark")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
            
            Text("User Not Found")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Please try searching with a different username.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    UserNotFoundView()
}

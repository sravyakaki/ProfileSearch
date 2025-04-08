//
//  UserDetailsModel.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

struct UserDetailsModel: Identifiable, Decodable, Hashable {
    let avatar_url: String
    let id: Int
    let name: String?
    let bio: String?
    let followers: Int
    let following: Int
    let followers_url: String
    let following_url: String
    let login: String
}

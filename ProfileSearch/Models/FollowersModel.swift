//
//  FollowersModel.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

// MARK: - FollowersModel
struct FollowersModel: Identifiable, Codable {
    var id: Int
    var login: String
    var avatar_url: String
    var name: String?
    var bio: String?
}

// MARK: - Extension UserDetailsModel
/* Save the user details to pass down to the Followers Model */
extension UserDetailsModel {
    init(from follower: FollowersModel) {
        self.init(
            avatar_url: follower.avatar_url,
            id: follower.id,
            name: follower.name,
            bio: follower.bio,
            followers: 0,
            following: 0,
            followers_url: "",
            following_url: "",
            login: follower.login
        )
    }
}

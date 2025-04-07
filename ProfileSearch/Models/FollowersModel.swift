//
//  FollowersModel.swift
//  ProfileSearch
//
//  Created by Sravya Kaki on 2025-04-07.
//

import Foundation

struct FollowersModel: Identifiable, Decodable {
    let id: Int
    let avatar_url: String
    let login: String
}

//
//  UserInfoData.swift
//  GitHubUsersSearch
//
//  Created by Vinay Ponnuri on 4/22/20.
//  Copyright © 2020 Vinay Ponnuri. All rights reserved.
//

import Foundation

struct UserInfoData: Decodable {

    enum CodingKeys: String, CodingKey {
        case name
        case email
        case location
        case created_at
        case followers
        case following
        case avatar_url
    }
    
    var name: String?
    var email: String?
    var location: String?
    var created_at: String?
    var followers: Int?
    var following: Int?
    var avatar_url: String?
    var thumbnail: URL? {
        guard let thumbnailString = avatar_url else { return nil }
        return URL(string: thumbnailString)
    }
   

    init () {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at) ?? ""
        avatar_url = try container.decodeIfPresent(String.self, forKey: .avatar_url) ?? ""
        followers = try container.decodeIfPresent(Int.self, forKey: .followers) ?? 0
        following = try container.decodeIfPresent(Int.self, forKey: .following) ?? 0
    }
}


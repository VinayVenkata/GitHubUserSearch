//
//  UsersRepoData.swift
//  GitHubUsersSearch
//
//  Created by Vinay Ponnuri on 4/22/20.
//  Copyright © 2020 Vinay Ponnuri. All rights reserved.
//

import Foundation

struct UsersRepoDataList: Decodable {
    var usersRepoData: [UsersRepoData]
    enum CodingKeys: String, CodingKey {
        case cardDetails
    }
    
    
    init (from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        if let containerCount = container.count, containerCount > 0 {
            var elements = [UsersRepoData]()
            while !container.isAtEnd {
                if let element = try? container.decode(UsersRepoData.self) {
                    elements.append(element)
                }
            }
            usersRepoData = elements
        } else {
            usersRepoData = [UsersRepoData]()
        }
    }
}

struct UsersRepoData: Decodable {

    enum CodingKeys: String, CodingKey {
        case repoCreated = "created_at"
        case repoName = "name"
        case forks
        case watchers
    }
    
    var repoCreated: String?
    var repoName: String?
    var forks: Int?
    var watchers: Int?
   

    init () {}

    init(withDict: [String: Any]) {
        repoCreated = withDict["created_at"] as? String ?? ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        repoCreated = try container.decodeIfPresent(String.self, forKey: .repoCreated) ?? ""
        repoName = try container.decodeIfPresent(String.self, forKey: .repoName) ?? ""
        forks = try container.decodeIfPresent(Int.self, forKey: .forks) ?? 0
        watchers = try container.decodeIfPresent(Int.self, forKey: .watchers) ?? 0
    }
}

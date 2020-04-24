//
//  SearchUsersData.swift
//  GitHubUsersSearch
//
//  Created by Vinay Ponnuri on 4/23/20.
//  Copyright © 2020 Vinay Ponnuri. All rights reserved.
//

import Foundation

struct SearchUsersData: Decodable {
    enum CodingKeys: String, CodingKey {
        case items
    }
    var items: [SearchUsersList]?
    
    init () {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decodeIfPresent([SearchUsersList].self, forKey: .items)
    }
}


struct SearchUsersList: Decodable {
     enum CodingKeys: String, CodingKey {
          case userName = "login"
          case repo = "repos_url"
          case image = "avatar_url"
          case followers =  "followers_url"
          case following =  "following_url"
          
      }
      
      var userName = ""
      var repo = ""
      var image: String?
      var followers: String?
      var following: String?
      var thumbnail: URL? {
          guard let thumbnailString = image else { return nil }
          return URL(string: thumbnailString)
      }
      var followersURL: URL? {
          guard let followersString = followers else { return nil }
          return URL(string: followersString)
      }
      var followingURL: URL? {
          guard let followingString = following else { return nil }
          return URL(string: followingString)
      }
     

      init () {}

      init(withDict: [String: Any]) {
          userName = withDict["login"] as? String ?? ""
          repo = withDict["repos_url"] as? String ?? ""
          image = withDict["avatar_url"] as? String ?? ""
          followers = withDict["followers_url"] as? String ?? ""
          following = withDict["following_url"] as? String ?? ""
          
      }

      init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          userName = try container.decodeIfPresent(String.self, forKey: .userName) ?? ""
          repo = try container.decodeIfPresent(String.self, forKey: .repo) ?? ""
          image = try container.decodeIfPresent(String.self, forKey: .image)
          followers = try container.decodeIfPresent(String.self, forKey: .followers)
          following = try container.decodeIfPresent(String.self, forKey: .following)
          
      }
}

//
//  NetworkService.swift
//  GitHubUsersSearch
//
//  Created by Vinay Ponnuri on 4/22/20.
//  Copyright © 2020 Vinay Ponnuri. All rights reserved.
//

import Foundation
import Alamofire

typealias dataHandler = ([String: AnyObject], Bool, Error?) -> Void
typealias usersCompletionHandler = (UsersDataList?, [UsersData]?, Error?) -> Void
typealias usersSearchCompletionHandler = ([SearchUsersList]?, [UsersData]?, Error?) -> Void
typealias usersRepoCompletionHandler = (UsersRepoDataList?, [UsersRepoData]?, Error?) -> Void
typealias usersInfoCompletionHandler = (UserInfoData?, Error?) -> Void
typealias completionHandler = ([UsersData]?, [UsersRepoData]?, Error?) -> Void

class NetworkService {
    static let decoder = JSONDecoder()

       private init() {}

       private struct Locals {
           static var manager: SessionManager?
       }

       class var networkManager: SessionManager {
           get {
               if Locals.manager == nil {
                   let configuration = URLSessionConfiguration.default
                   let _manager = SessionManager(configuration: configuration)
                   Locals.manager = _manager

               }
               return Locals.manager!

           }
       }
       
    static func getUsers(handler: @escaping usersCompletionHandler) {
        
        let request = NetworkRequest.getUsersRequest()
        
        networkManager.request(request)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    if let users = response.result.value as? [[String: Any]], let data = response.data,
                        let convertUsers = try? NetworkService.decoder.decode(UsersDataList.self, from: data), users.count > 0 {
                        handler(convertUsers, convertUsers.usersData, nil)
                    }
                case .failure(let error):
                    if let error = error as? URLError {
                        _ = "Error while getting the card details" + error.localizedDescription
                    }
                    handler(nil, nil, error)
                }
            })
    }
    
    static func searchUsers(searchText: String, handler: @escaping usersSearchCompletionHandler) {
        
        let request = NetworkRequest.getUsersSearchRequest(searchText: searchText)
        
        networkManager.request(request)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    if let users = response.result.value as? [String: Any], let data = response.data,
                        let convertUsers = try? NetworkService.decoder.decode(SearchUsersData.self, from: data), users.count > 0 {
                        handler(convertUsers.items, nil, nil)
                    }
                case .failure(let error):
                    if let error = error as? URLError {
                        _ = "Error while getting the card details" + error.localizedDescription
                    }
                    handler(nil, nil, error)
                }
            })
    }
    
    static func getUsersRepo(url: String, handler: @escaping usersRepoCompletionHandler) {
        let request = NetworkRequest.getUsersRepoRequest(url: url)
        
        networkManager.request(request)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    if let users = response.result.value as? [[String: Any]], let data = response.data,
                     let convertUsers = try? NetworkService.decoder.decode(UsersRepoDataList.self, from: data), users.count > 0 {
                        handler(convertUsers, convertUsers.usersRepoData, nil)
                    }
                case .failure(let error):
                    if let error = error as? URLError {
                        _ = "Error while getting the card details" + error.localizedDescription
                    }
                    handler(nil, nil, error)
                }
            })
    }
    
    static func getUserInfo(url: String, handler: @escaping usersInfoCompletionHandler) {
        let request = NetworkRequest.getUserInfoRequest(url: url)
        
        networkManager.request(request)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    if let _ = response.result.value as? [String: Any], let data = response.data,
                     let convertUserInfo = try? NetworkService.decoder.decode(UserInfoData.self, from: data) {
                        handler(convertUserInfo, nil)
                    }
                case .failure(let error):
                    if let error = error as? URLError {
                        _ = "Error while getting the card details" + error.localizedDescription
                    }
                    handler(nil, error)
                }
            })
    }
    
}

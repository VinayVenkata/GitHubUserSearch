//
//  NetworkRequest.swift
//  GitHubUsersSearch
//
//  Created by Vinay Ponnuri on 4/22/20.
//  Copyright © 2020 Vinay Ponnuri. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NetworkRequest {
    
    static func getUsersRequest() -> URLRequest {
        let baseUrl = "https://api.github.com/users"
        var request = URLRequest(url: NSURL(string: baseUrl)! as URL)
        request.httpMethod = "GET"
        
        return request
    }
    
    static func getUsersSearchRequest(searchText: String) -> URLRequest {
        let baseUrl = "https://api.github.com/search/users?q=\(searchText)"
        var request = URLRequest(url: NSURL(string: baseUrl)! as URL)
        request.httpMethod = "GET"
        
        return request
    }
    
    static func getUsersRepoRequest(url: String) -> URLRequest {
        let baseUrl = "https://api.github.com/users/\(url)/repos"
        var request = URLRequest(url: NSURL(string: baseUrl)! as URL)
        request.httpMethod = "GET"
        
        return request
    }
    
    static func getUserInfoRequest(url: String) -> URLRequest {
    let baseUrl = "https://api.github.com/users/\(url)"
        var request = URLRequest(url: NSURL(string: baseUrl)! as URL)
        request.httpMethod = "GET"
        
        return request
    }
}

extension URLRequest {
    static func addHeaders(toRequest: URLRequest) -> URLRequest {
        var incomingRequest = toRequest

        incomingRequest.addValue("", forHTTPHeaderField: "")
        return incomingRequest
    }
    
    static func addPostHeaders(toRequest: URLRequest) -> URLRequest {
           var incomingRequest = toRequest

           incomingRequest.httpMethod = "POST"
           incomingRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
           incomingRequest.addValue("en", forHTTPHeaderField: "Accept-Language")

           return URLRequest.addHeaders(toRequest: incomingRequest)
       }
       
       static func addGetHeaders(toRequest: URLRequest) -> URLRequest {
           var incomingRequest = toRequest
           incomingRequest.httpMethod = "GET"
           incomingRequest.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
           incomingRequest.addValue("en", forHTTPHeaderField: "Accept-Language")

           return URLRequest.addHeaders(toRequest: incomingRequest)
       }
}

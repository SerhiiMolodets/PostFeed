//
//  PostEndpoint.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import Foundation

enum PostEndpoint: Endpoint {
    
    case list
    case detail(id: String)
    
    var path: String {
        switch self {
        case .list:
            return "/anton-natife/jsons/master/api/main.json"
        case .detail(id: let id):
            return "/anton-natife/jsons/master/api/posts/\(id).json"
        }
    }
    var method: RequestMethod {
        switch self {
        case .detail, .list:
            return .get
        }
    }
    var header: [String: String]? {
        return nil
    }
    var body: [String: String]? {
        return nil
    }
    var queryItems: [URLQueryItem]? {
        return nil
    }

}


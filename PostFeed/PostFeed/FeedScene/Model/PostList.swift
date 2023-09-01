//
//  PostList.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import Foundation

struct PostListContainer: Codable {
    let posts: [Post]?
}

struct Post: Codable, Comparable {
    static func < (lhs: Post, rhs: Post) -> Bool {
        return lhs.title < rhs.title
    }
    let postId, timeshamp: Int
    let title, previewText: String
    let likesCount: Int
    var isCollapsed: Bool? = true
}



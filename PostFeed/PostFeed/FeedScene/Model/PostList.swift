//
//  PostList.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import Foundation

struct PostListContainer: Decodable {
    let posts: [Post]?
}

struct Post: Decodable {
    let postId: Int
    let timeshamp: TimeInterval
    let title, previewText: String
    let likesCount: Int
}



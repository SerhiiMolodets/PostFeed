//
//  DetailPosts.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import Foundation

struct DetailPostContainer: Codable {
    let post: DetailPost
}

struct DetailPost: Codable {
    let postId, timeshamp: Int
    let title, text: String
    let postImage: String
    let likesCount: Int

}

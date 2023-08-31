//
//  PostNetworkService.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import Foundation

protocol PostNetworkServiceProtocol {
    func getList() async throws -> PostListContainer
    func getDetail(id: String) async throws -> DetailPostContainer
}

struct PostNetworkService: HTTPClient, PostNetworkServiceProtocol {

    private let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
    
    func getList() async throws -> PostListContainer {
        do {
            return try await sendRequest(
                endpoint: PostEndpoint.list,
                useCache: false,
                decoder: decoder
            )
        } catch {
            throw error
        }
    }
    
    func getDetail(id: String) async throws -> DetailPostContainer {
        do {
            return try await sendRequest(
                endpoint: PostEndpoint.detail(id: id),
                useCache: true,
                decoder: decoder
            )
        } catch {
            throw error
        }
    }
}

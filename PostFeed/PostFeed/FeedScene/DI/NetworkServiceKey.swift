//
//  NetworkServiceKey.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import Foundation

private struct NetworkServiceKey: InjectionKey {
    static var currentValue: PostNetworkServiceProtocol = PostNetworkService()
}


extension InjectedValues {
    var networkService: PostNetworkServiceProtocol {
        get { Self[NetworkServiceKey.self] }
        set { Self[NetworkServiceKey.self] = newValue }
    }
}

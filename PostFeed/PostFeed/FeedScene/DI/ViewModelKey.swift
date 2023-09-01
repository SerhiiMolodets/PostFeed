//
//  FeedViewModelKey.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import Foundation

private struct ViewModelKey: InjectionKey {
    static var currentValue: ViewModelProtocol = ViewModel()
}


extension InjectedValues {
    var viewModel: ViewModelProtocol {
        get { Self[ViewModelKey.self] }
        set { Self[ViewModelKey.self] = newValue }
    }
}

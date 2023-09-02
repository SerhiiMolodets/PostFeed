//
//  FeedViewModel.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import Foundation
import RxSwift
import RxRelay

protocol ViewModelProtocol {
    var listData: BehaviorRelay<[Post]> { get }
}

class ViewModel: ViewModelProtocol {
    @Injected(\.networkService) var networkService
    let listData = BehaviorRelay<[Post]>.init(value: [])
    
    init() {
        Task {
            await getListData()
        }
    }
    
    private func getListData() async {
        do {
            guard let data = try await networkService.getList().posts else { return }
            listData.accept(data)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}

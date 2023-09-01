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
    var listData: PublishSubject<[Post]> { get }
}

class ViewModel: ViewModelProtocol {
    @Injected(\.networkService) var networkService
    let listData = PublishSubject<[Post]>()
    
    init() {
        Task {
            await getListData()
        }
    }
    
    private func getListData() async {
        do {
            guard let data = try await networkService.getList().posts else { return }
            listData.onNext(data)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}

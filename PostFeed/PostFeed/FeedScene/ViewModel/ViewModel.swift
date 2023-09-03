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
    var openDetail: PublishSubject<Int> { get }
    var detailData: DetailPost? { get set }
}

final class ViewModel: ViewModelProtocol {
    @Injected(\.networkService) var networkService
    let listData = BehaviorRelay<[Post]>.init(value: [])
    let openDetail = PublishSubject<Int>()
    var detailData: DetailPost?
    let bag = DisposeBag()
    
    init() {
        Task {
            await getListData()
        }
        bindingDetailData()
    }
    
    private func getListData() async {
        do {
            guard let data = try await networkService.getList().posts else { return }
            listData.accept(data)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func getDetails(with id: Int) async {
        do {
            let data = try await networkService.getDetail(id: "\(id)")
            detailData = data.post
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func bindingDetailData() {
        openDetail
            .subscribe { [weak self] id in
                Task { [weak self] in
                    await self?.getDetails(with: id)
                }
            }.disposed(by: bag)
    }
    
}

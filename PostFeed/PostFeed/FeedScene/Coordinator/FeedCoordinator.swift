//
//  FeedCoordinator.swift
//  PostFeed
//
//  Created by Serhii Molodets on 30.08.2023.
//

import UIKit
import RxSwift

final class FeedCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    @Injected(\.viewModel) var viewModel
    let bag = DisposeBag()
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = FeedViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        bindNavigation()
    }
    
    private func bindNavigation() {
        viewModel.openDetail.asObservable()
            .subscribe { [weak self] id in
                self?.openDetail()
            }.disposed(by: bag)
    }
    
    private func openDetail() {
        let viewController = DetailViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    deinit {
        print("deinit")
    }
}

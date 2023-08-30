//
//  FeedCoordinator.swift
//  PostFeed
//
//  Created by Serhii Molodets on 30.08.2023.
//

import UIKit

final class FeedCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = FeedViewController()
//        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    deinit {
        debugPrint("LoosesListCoordinator deinit")
    }
}

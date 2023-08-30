//
//  AppCoordinator.swift
//  PostFeed
//
//  Created by Serhii Molodets on 30.08.2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    var window: UIWindow? { get }
}

final class AppCoordinator: AppCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        openFeedScene()
    }
    
    private func openFeedScene() {
        let coordinator = FeedCoordinator(navigationController: navigationController)
        coordinator.start()
    }
    
    
}

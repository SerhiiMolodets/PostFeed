//
//  ViewController.swift
//  PostFeed
//
//  Created by Serhii Molodets on 30.08.2023.
//

import UIKit

class FeedViewController: UIViewController {
    let net = PostNetworkService()
    var list = PostListContainer(posts: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                list = try await net.getList()
                print(list.posts!)
            } catch {
                print(error.localizedDescription)
            }

        }
        
    }
    
    
}


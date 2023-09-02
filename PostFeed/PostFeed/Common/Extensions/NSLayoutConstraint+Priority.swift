//
//  Fil.swift
//  PostFeed
//
//  Created by Serhii Molodets on 02.09.2023.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

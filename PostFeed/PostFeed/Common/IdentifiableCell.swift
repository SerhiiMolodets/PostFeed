//
//  IdentifiableCell.swift
//  PostFeed
//
//  Created by Serhii Molodets on 03.09.2023.
//

import Foundation

protocol IdentifiableCell {}

extension IdentifiableCell {
    static var identifier: String { String(describing: Self.self) }
}

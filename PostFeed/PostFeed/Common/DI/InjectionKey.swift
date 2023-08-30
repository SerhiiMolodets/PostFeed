//
//  InjectionKey.swift
//  PostFeed
//
//  Created by Serhii Molodets on 30.08.2023.
//

import Foundation

protocol InjectionKey {

   associatedtype Value

   static var currentValue: Self.Value { get set }
}

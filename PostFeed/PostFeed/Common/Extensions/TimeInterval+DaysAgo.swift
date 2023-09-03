//
//  TimeInterval+DaysAgo.swift
//  PostFeed
//
//  Created by Serhii Molodets on 03.09.2023.
//

import Foundation

extension TimeInterval {
     func daysAgo() -> Int {
        let date = Date(timeIntervalSince1970: self)
        let currentDate = Date()
        let timeDifference = currentDate.timeIntervalSince(date)
        let daysAgo = Int(timeDifference / (60 * 60 * 24))
        return daysAgo
    }
}

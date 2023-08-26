//
//  ViewDay.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-10.
//

import Foundation

//MARK: - Main model
struct ACViewDay: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let articlesCount: Int
}


//MARK: - Model list example
extension ACViewDay {
    
    //MARK: Static
    static let example = [
        ACViewDay(date: Date.from(year: 2023, month: 7, day: 1), articlesCount: 5),
        ACViewDay(date: Date.from(year: 2023, month: 7, day: 2), articlesCount: 4),
        ACViewDay(date: Date.from(year: 2023, month: 7, day: 3), articlesCount: 7),
        ACViewDay(date: Date.from(year: 2023, month: 7, day: 4), articlesCount: 3),
        ACViewDay(date: Date.from(year: 2023, month: 7, day: 5), articlesCount: 5),
        ACViewDay(date: Date.from(year: 2023, month: 7, day: 6), articlesCount: 2),
        ACViewDay(date: Date.from(year: 2023, month: 7, day: 7), articlesCount: 3)
    ]
}


//MARK: - Comparable protocol extension
extension ACViewDay: Comparable {
    
    //MARK: Static
    static func ==(lhs: ACViewDay, rhs: ACViewDay) -> Bool {
        return lhs.articlesCount == rhs.articlesCount
    }

    static func <(lhs: ACViewDay, rhs: ACViewDay) -> Bool {
        return lhs.articlesCount < rhs.articlesCount
    }
}

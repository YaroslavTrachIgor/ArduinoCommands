//
//  DateExtensions.swift
//  ArduinoCommands
//
//  Created by User on 11.08.2022.
//

import Foundation

//MARK: - Keys
public extension Date {
    
    //MARK: Public
    enum Keys {
        
        //MARK: Static
        public static let basicFormat = "yyyy-MM-dd"
        public static let basicLocale = "en_US_POSIX"
    }
}


//MARK: - Fast Date preparation methods extension
public extension Date {

    //MARK: Static
    /// This gets `Date` using such:
    /// - Parameters:
    ///   - year: number of year;
    ///   - month: number of month;
    ///   - day: number of day;
    /// - Returns: converted `Date` according to tha argument values.
    static func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    /// This gets `Date` using such:
    /// - Parameters:
    ///   - string: date string description;
    ///   - format: date string format;
    /// - Returns: converted `Date` according to tha argument values.
    static func parse(_ string: String, format: String = Keys.basicFormat) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: string)!
        return date
    }
    
    /// This converts `Date` in basic string description.
    /// This will be usually used in uiModels to create costom footers.
    /// - Returns: date mask(for instance: `December 12, 2020`)
    static func description(for date: Date!) -> String {
        let dateFormatter = DateFormatter()
        let localeIdentifier = Keys.basicLocale
        let locale = NSLocale(localeIdentifier: localeIdentifier)
        dateFormatter.dateStyle = .long
        dateFormatter.locale = locale as Locale
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}

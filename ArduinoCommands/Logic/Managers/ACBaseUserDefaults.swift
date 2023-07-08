//
//  ACBaseUserDefaults.swift
//  ArduinoCommands
//
//  Created by User on 22.08.2022.
//

import Foundation
import UIKit

//MARK: - Keys
public extension UserDefaults {
    
    //MARK: Private
    enum Keys {
        
        //MARK: Static
        static let allowNotifications = "AllowsNotificationsKey"
        static let allowAnalytics = "AllowAnalyticsKey"
        static let analyticsViewDays = "AnalyticsViewDaysKey"
        static let analyticsDailyGoal = "AnalyticsDailyGoalKey"
        static let analyticsArticlesCount = "AnalyticsArticlesCountKey"
        static let isOnboardingNeeded = "IsNeededToBeOpenedKey"
        static let sessionsCountKey = "SessionsCountKey"
        static let checkVersionKey = "CheckVersionKey"
        static let codeFontSize = "CodeFontSizeKey"
        static let codeTintColorKey = "CodeTintColorKey"
        static let detailsTintColorrKey = "DetailsTintColorrKey"
    }
}


//MARK: - Global UserDefaults type value
/**
 The constant below creates a global instance of `UserDefaults` store
 and will be used every time we need to store and retrieve values from the phone memory.
 */
public let acBaseUserDefaults = UserDefaults.standard


//MARK: - Fast Wrapper for UserDefaults storage values
/**
 Every time when we need to save something and we use `UserDefaults` storage,
 we will need to do a bunch of uncomfortable things to save only one property into Phone memory.
 
 That's why we create a special `@propertyWrapper` structure
 that will let us use Defaults values as usual varibles in Swift.
 */
@propertyWrapper
public struct ACBaseUserDefaults<Value> {
    
    //MARK: Private
    private let key: String
    private let storage: UserDefaults
    private let defaultValue: Value
    
    //MARK: Public
    public var wrappedValue: Value {
        get { storage.value(forKey: key) as? Value ?? defaultValue }
        set { storage.setValue(newValue, forKey: key) }
    }

    
    //MARK: Initializate
    init(wrappedValue defaultValue: Value,
         key: String,
         storage: UserDefaults = acBaseUserDefaults) {
        self.defaultValue = defaultValue
        self.storage = storage
        self.key = key
    }
}


//MARK: - Fast Wrapper for UserDefaults storage Color values
/**
 For the sake of convenience when we need
 to save properties of type `UIColor` to the `UserDefaults` storage,
 we create a special `@propertyWrapper` structure
 that will let us quickly save and get color values as we do for usual varibles in Swift.
 */
@propertyWrapper
public struct ACBaseUserDefaultsColor {
    
    //MARK: Private
    private let key: String
    private let storage: UserDefaults
    private let defaultValue: UIColor
    
    //MARK: Public
    public var wrappedValue: UIColor {
        get { acBaseUserDefaults.color(forKey: key) ?? defaultValue }
        set { acBaseUserDefaults.set(newValue, forKey: key) }
    }

    
    //MARK: Initializate
    init(wrappedValue defaultValue: UIColor = .init(),
         key: String,
         storage: UserDefaults = acBaseUserDefaults) {
        self.defaultValue = defaultValue
        self.storage = storage
        self.key = key
    }
}

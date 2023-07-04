//
//  ACSettingsManager.swift
//  ArduinoCommands
//
//  Created by User on 16.10.2022.
//

import Foundation

//MARK: - Manager for fast access to the Settings parameters
final class ACSettingsManager {
    
    //MARK: Static
    static let shared = ACSettingsManager()
    
    //MARK: Initialization
    private init() {}
    
    
    //MARK: Public
    /**
     All variables below will be subject to change in the `SettingsView`.
     In order to easily access the objects and services of this manager,
     we will use the Singleton design pattern.
     
     User will change these Settings properties to block unwanted features of the App.
     */
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.allowNotifications)
    public var allowNotifications = true
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.allowAnalytics)
    public var allowAnalytics = true
}

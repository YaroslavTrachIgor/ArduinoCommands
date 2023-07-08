//
//  ACSettingsManager.swift
//  ArduinoCommands
//
//  Created by User on 16.10.2022.
//

import Foundation

//MARK: - Manager for Settings parameters
final class ACSettingsParametersManager {
    
    //MARK: Static
    static let shared = ACSettingsParametersManager()
    
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
}

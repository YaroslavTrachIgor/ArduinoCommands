//
//  ACRateManager.swift
//  ArduinoCommands
//
//  Created by User on 09.07.2022.
//

import Foundation
import UIKit

//MARK: - Manager Injector protocol
protocol RateManagerInjector {
    var rateManager: ACRateManager { get }
}


//MARK: - Main Manager instance
fileprivate let sharedRateManager: ACRateManager = ACRateManager.shared


//MARK: - Manager Injector protocol extension
extension RateManagerInjector {
    
    //MARK: Internal
    var rateManager: ACRateManager {
        return sharedRateManager
    }
}


//MARK: - Maneger for App rating by user
final public class ACRateManager {

    //MARK: Private
    @ACBaseUserDefaults<Int>(key: UserDefaults.Keys.Onboarding.sessionsCountKey)
    private var sessionsCount = 0
    
    //MARK: Static
    static var shared = ACRateManager()
    
    
    //MARK: Initialization
    private init() {}
    
    //MARK: Public
    func startCounting() {
        /**
         In order to keep track of the number of times the user has opened the application,
         we create a variable that will be stored in `UserDefaults`.
         
         Call this function in the `AppDelegate` file.
         */
        sessionsCount += 1
    }
    
    func checkSession(completion: @escaping ACBaseCompletionHandler) {
        let isNeeded = sessionsCount % 10 == 0
        /**
         In the code below, before showing an alert that will give the user the opportunity to rate the application,
         we check that the user has already opened it five times.
         In the future, we will not show this alert anymore.
         */
        if isNeeded {
            completion()
        }
    }
}

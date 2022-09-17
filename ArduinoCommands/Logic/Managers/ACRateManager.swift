//
//  ACRateManager.swift
//  ArduinoCommands
//
//  Created by User on 09.07.2022.
//

import Foundation
import StoreKit
import UIKit

//MARK: - Keys
private extension ACRateManager {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Alert {
                enum RateAlert {
                    
                    //MARK: Static
                    static var title = "Do you enjoy using ArduinoCommands?"
                    static var message = "Your opinion is very important for us."
                    static let noActionTitle = "No, I don't"
                    static let yesActionTitle = "Yes, I like it!"
                    static let dismissActionTitle = "Dismiss"
                }
                enum ThanksAlert {
                    
                    //MARK: Static
                    static var title = "Thank you!"
                    static var message = "We will keep improving our Application."
                }
            }
        }
    }
}

//MARK: - Maneger for App rating by user
final public class ACRateManager {

    //MARK: Private
    @ACBaseUserDefaults<Int>(key: UserDefaults.Keys.sessionsCountKey)
    private var sessionsCount = 0
    
    //MARK: Weak
    weak var currentViewController: UIViewController?
    
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
    
    func presentRateAlert() {
        let isNeeded = sessionsCount % 10 == 0
        let rateAlert = setupRateAlert()
        /**
         In the code below, before showing an alert that will give the user the opportunity to rate the application,
         we check that the user has already opened it five times.
         In the future, we will not show this alert anymore.
         */
        if isNeeded {
            currentViewController?.present(rateAlert, animated: true)
        }
    }
}


//MARK: - Main methods
private extension ACRateManager {
    
    //MARK: Private
    func setupRateAlert() -> UIAlertController {
        let title = Keys.UI.Alert.RateAlert.title
        let message = Keys.UI.Alert.RateAlert.message
        let noActionTitle = Keys.UI.Alert.RateAlert.noActionTitle
        let yesActionTitle = Keys.UI.Alert.RateAlert.yesActionTitle
        let dismissActionTitle = Keys.UI.Alert.RateAlert.dismissActionTitle
        let rateAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let noAlert = UIAlertAction(title: noActionTitle, style: .default) { [weak self] _ in
            self?.presentThanksAlert()
        }
        let yesAction = UIAlertAction(title: yesActionTitle, style: .default, handler: { [weak self] _ in
            self?.presentStoreReviewController()
        })
        let dismissAction = UIAlertAction(title: dismissActionTitle, style: .cancel)
        rateAlert.view.tintColor = .label
        rateAlert.addAction(yesAction)
        rateAlert.addAction(noAlert)
        rateAlert.addAction(dismissAction)
        return rateAlert
    }
    
    func presentStoreReviewController() {
        guard let scene = currentViewController?.view.window?.windowScene else { return }
        SKStoreReviewController.requestReview(in: scene)
    }
    
    func presentThanksAlert() {
        let title = Keys.UI.Alert.ThanksAlert.title
        let message = Keys.UI.Alert.ThanksAlert.message
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   duration: 2,
                                   preset: .heart)
    }
}

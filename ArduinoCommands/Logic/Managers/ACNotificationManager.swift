//
//  ACNotificationManager.swift
//  ArduinoCommands
//
//  Created by User on 01.07.2022.
//

import Foundation
import UserNotifications
import SwiftUI

//MARK: - Keys
private extension ACNotificationManager {
    
    //MARK: Private
    enum Keys {
        enum NotificationContent {
            
            //MARK: Static
            static let commandNotificationBody = "Do not forget that you have set a reminder for this command, so open the app as soon as possible and continue your learning!"
        }
        enum Alert {
            enum Titles {
                
                //MARK: Static
                static let failedAlertTitle = "Not available"
                static let successAlertTitle = "Success"
            }
            enum Messages {
                
                //MARK: Static
                static let errorAlertMessage = "The notifications have been blocked by the user."
                static let failedAlertMessage = "Check your Notification settings for this app."
                static let successAlertMessage = "Command Notification has been set."
            }
        }
    }
}


//MARK: - Manager fpr fast Notifications sending
final public class ACNotificationManager {
    
    //MARK: Static
    static let shared = ACNotificationManager()
    
    //MARK: Public
    var notificationsEnabled: Bool = false
    
    //MARK: Initializaion
    private init() {}
    
    
    //MARK: Public
    func sendNotification(title: String, subtitle: String, body: String, date: Date) {
        let content = setupFastNotificationContent(title: title, subtitle: subtitle, body: body)
        let dateComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let triggerDate = Calendar.current.dateComponents(dateComponents, from: date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [self] success, error in
            DispatchQueue.main.async { [self] in
                if !success {
                    presentErrorAlert(error: error)
                } else {
                    notificationsEnabled = true
                }
            }
        }
    }
}


//MARK: - Setup application basic Notification types
public extension ACNotificationManager {
    
    //MARK: Public
    func sendCommandNotification(with command: ACCommand, for date: Date) {
        let title = command.name!
        let subtitle = command.subtitle!
        let body = Keys.NotificationContent.commandNotificationBody
        sendNotification(title: title,
                         subtitle: subtitle,
                         body: body,
                         date: date)
    }
}


//MARK: - Setup Notification setting result Alerts
public extension ACNotificationManager {
    
    //MARK: Public
    func presentFailedNotificationSetAlert() {
        let title = Keys.Alert.Titles.failedAlertTitle
        let message = Keys.Alert.Messages.failedAlertMessage
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   duration: 3.5,
                                   preset: .error)
    }
    
    func presentSuccesedNotificationSetAlert() {
        let title = Keys.Alert.Titles.successAlertTitle
        let message = Keys.Alert.Messages.successAlertMessage
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   duration: 4,
                                   preset: .done)
    }
}


//MARK: - Main Methods
private extension ACNotificationManager {
    
    //MARK: Private
    func presentErrorAlert(error: Error?) {
        let title = Keys.Alert.Titles.failedAlertTitle
        let message = Keys.Alert.Messages.errorAlertMessage
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   duration: 5,
                                   preset: .error)
    }
    
    func setupFastNotificationContent(title: String, subtitle: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.body = body
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        return content
    }
}

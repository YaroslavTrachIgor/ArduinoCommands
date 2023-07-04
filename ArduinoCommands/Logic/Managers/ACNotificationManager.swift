//
//  ACNotificationManager.swift
//  ArduinoCommands
//
//  Created by User on 01.07.2022.
//

import Foundation
import UserNotifications
import SwiftUI

//MARK: - Constants
private extension ACNotificationManager {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum CommandNotification {
                
                //MARK: Static
                static let body = "Do not forget that you have set a reminder for this command, so open the app as soon as possible and continue your learning!"
            }
        }
    }
}


//MARK: - Manager fpr fast Notifications sending
public final class ACNotificationManager {
    
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
                    ACGrayAlertManager.presentNotificationErrorAlert(error: error)
                } else {
                    notificationsEnabled = true
                }
            }
        }
    }
}


//MARK: - Setup common Notification requests
extension ACNotificationManager {
    
    //MARK: Public
    func sendCommandNotification(with command: ACCommand, date: Date = Date()) {
        let title = command.name
        let subtitle = command.subtitle
        let body = Constants.UI.CommandNotification.body
        ACNotificationManager.shared.sendNotification(title: title!,
                                                      subtitle: subtitle!,
                                                      body: body,
                                                      date: date)
    }
}


//MARK: - Main Methods
private extension ACNotificationManager {
    
    //MARK: Private
    func setupFastNotificationContent(title: String, subtitle: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.body = body
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        return content
    }
}

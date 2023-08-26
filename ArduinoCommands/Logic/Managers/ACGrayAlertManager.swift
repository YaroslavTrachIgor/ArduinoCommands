//
//  ACGrayAlertManager.swift
//  ArduinoCommands
//
//  Created by User on 27.06.2022.
//

import Foundation
import AlertKit
import UIKit

//MARK: - Constants
private extension ACGrayAlertManager {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum CopiedAlert {
                
                //MARK: Static
                static let title = "Copied"
                static let message = " was copied to Pasteboard."
            }
            enum NewVersionAlert {
                
                //MARK: Static
                static let title = "New Version"
                static let message = "The New Version of Arduino Commands is available in App Store."
                static let presetImageName = "app.gift.fill"
                static let duration = CGFloat(6)
            }
            enum Notification {
                enum ErrorAlert {
                    
                    //MARK: Static
                    static let message = "The notifications have been blocked by the user."
                    static let duration = CGFloat(5)
                }
                enum FailedAlert {
                    
                    //MARK: Static
                    static let title = "Not available"
                    static let message = "Check your Notification settings for this app."
                    static let duration = CGFloat(4.5)
                }
                enum SuccessAlert {
                    
                    //MARK: Static
                    static let title = "Notification has been set"
                    static let duration = CGFloat(3)
                }
            }
        }
    }
}


//MARK: - Manager for fast 'SPAlert' setup and presenting
final public class ACGrayAlertManager {
    
    //MARK: Static
    static func present(title: String?,
                        message: String? = nil,
                        duration: TimeInterval = 4,
                        cornerRadius: CGFloat = 18,
                        icon: AlertIcon = .done,
                        style: AlertViewStyle = .iOS16AppleMusic) {
        AlertKitAPI.present(
            title: title,
            icon: icon,
            style: style
        )
    }
}


//MARK: - Preparing basic Alert View types
extension ACGrayAlertManager {
    
    //MARK: Static
    static func presentCopiedAlert(contentType: ACPasteboardManager.ContentType = .content) {
        let title = Constants.UI.CopiedAlert.title
        let message = contentType.rawValue + Constants.UI.CopiedAlert.message
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   icon: .done,
                                   style: .iOS17AppleMusic)
    }
    
    static func presentNewVersionAlert() {
        let title = Constants.UI.NewVersionAlert.title
        let message = Constants.UI.NewVersionAlert.message
        let presetImage = UIImage(systemName: Constants.UI.NewVersionAlert.presetImageName)!
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   icon: .custom(presetImage))
    }
    
    static func presentFailedNotificationSetAlert() {
        let title = Constants.UI.Notification.FailedAlert.title
        let message = Constants.UI.Notification.FailedAlert.message
        let duration = Constants.UI.Notification.FailedAlert.duration
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   duration: duration,
                                   icon: .error,
                                   style: .iOS16AppleMusic)
    }
    
    static func presentSuccesedNotificationSetAlert() {
        let title = Constants.UI.Notification.SuccessAlert.title
        let duration = Constants.UI.Notification.SuccessAlert.duration
        ACGrayAlertManager.present(title: title,
                                   duration: duration,
                                   style: .iOS17AppleMusic)
    }
    
    static func presentNotificationErrorAlert(error: Error?) {
        let title = Constants.UI.Notification.FailedAlert.title
        let duration = Constants.UI.Notification.ErrorAlert.duration
        ACGrayAlertManager.present(title: title,
                                   duration: duration,
                                   icon: .error,
                                   style: .iOS17AppleMusic)
    }
}



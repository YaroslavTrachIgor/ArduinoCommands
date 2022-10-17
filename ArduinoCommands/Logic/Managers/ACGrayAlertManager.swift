//
//  ACGrayAlertManager.swift
//  ArduinoCommands
//
//  Created by User on 27.06.2022.
//

import Foundation
import SPAlert
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
                static let cornerRadius: CGFloat = 20
                static let duration: CGFloat = 8
            }
        }
    }
}


//MARK: - Manager for fast 'SPAlert' setup and presenting
final public class ACGrayAlertManager {
    
    //MARK: Static
    static func present(title: String?,
                        message: String?,
                        duration: TimeInterval = 4,
                        cornerRadius: CGFloat = 18,
                        preset: SPAlertIconPreset = .done) {
        let alertView = SPAlertView(title: title!, message: message, preset: preset)
        alertView.cornerRadius = cornerRadius
        alertView.dismissByTap = true
        alertView.duration = duration
        alertView.present()
    }
}


//MARK: - Creating basic Alert View types
extension ACGrayAlertManager {
    
    //MARK: Static
    static func presentCopiedAlert(contentType: ACPasteboardManager.ContentType = .content) {
        let title = Constants.UI.CopiedAlert.title
        let message = contentType.rawValue + Constants.UI.CopiedAlert.message
        ACGrayAlertManager.present(title: title, message: message)
    }
    
    static func presentNewVersionAlert() {
        let title = Constants.UI.NewVersionAlert.title
        let message = Constants.UI.NewVersionAlert.message
        let cornerRadius = Constants.UI.NewVersionAlert.cornerRadius
        let presetImage = UIImage(systemName: Constants.UI.NewVersionAlert.presetImageName)!
        ACGrayAlertManager.present(title: title, message: message, cornerRadius: cornerRadius, preset: .custom(presetImage))
    }
}

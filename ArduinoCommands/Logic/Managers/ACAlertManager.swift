//
//  ACAlertManager.swift
//  ArduinoCommands
//
//  Created by User on 13.07.2022.
//

import Foundation
import UIKit

//MARK: - Constants
private extension ACAlertManager {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Action {
                
                //MARK: Static
                static let cancelActionTitle = "Cancel"
                static let dismissActionTitle = "Dismiss"
            }
        }
    }
}


//MARK: - Manager for fast Alert presenting
final public class ACAlertManager {
    
    //MARK: Static
    static let shared = ACAlertManager()
    
    
    //MARK: Initializaion
    private init() {}
}


//MARK: - Setup basic Alert types
public extension ACAlertManager {
    
    //MARK: Public
    func presentSimple(title: String?,
                       message: String?,
                       tintColor: UIColor = .link,
                       on vc: UIViewController) {
        let dismissActionTitle = Constants.UI.Action.dismissActionTitle
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissActionTitle, style: .cancel)
        alertVC.addAction(dismissAction)
        alertVC.view.tintColor = tintColor
        vc.present(alertVC, animated: true)
    }
    func presentSimpleWithAction(title: String?,
                                 message: String?,
                                 actionTitle: String,
                                 tintColor: UIColor = .label,
                                 actionHandler: ((UIAlertAction) -> Void)? = nil,
                                 on vc: UIViewController) {
        let cancelActionTitle = Constants.UI.Action.cancelActionTitle
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default, handler: actionHandler)
        let continueAction = UIAlertAction(title: cancelActionTitle, style: .cancel)
        alertVC.addAction(alertAction)
        alertVC.addAction(continueAction)
        alertVC.view.tintColor = tintColor
        vc.present(alertVC, animated: true)
    }
}


//MARK: - Setup basic ActionSheet types
public extension ACAlertManager {
    
    //MARK: Public
    func presentSimpleActionSheet(title: String?,
                                  message: String?,
                                  actionTitle: String,
                                  actionHandler: ((UIAlertAction) -> Void)? = nil,
                                  tintColor: UIColor = .link,
                                  on vc: UIViewController) {
        let cancelActionTitle = Constants.UI.Action.cancelActionTitle
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let actionSheetAction = UIAlertAction(title: actionTitle, style: .default, handler: actionHandler)
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel)
        actionSheet.addAction(actionSheetAction)
        actionSheet.addAction(cancelAction)
        actionSheet.view.tintColor = tintColor
        vc.present(actionSheet, animated: true)
    }
}

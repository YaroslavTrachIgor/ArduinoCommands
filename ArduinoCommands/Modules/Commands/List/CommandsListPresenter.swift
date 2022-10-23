//
//  CommandsListPresenter.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.05.2022.
//

import Foundation
import UIKit

//MARK: - Presenter protocol
internal protocol CommandsListPresenterProtocol {
    init(view: CommandsListTableViewControllerProtocol, models: [ACCommandsSection]?)
    func onViewDidLoad(completionHandler: (([ACCommandsSection]) -> Void))
    func onRemindRowAction(currentCommand: ACCommand)
    func onShareRowAction(currentCommand: ACCommand)
    func onDidSelectRow(with sender: IndexPath)
    func onAdLooadFail()
}


//MARK: - Main Presenter
final class CommandsListPresenter {
    
    //MARK: Private
    private weak var view: CommandsListTableViewControllerProtocol?
    private var models: [ACCommandsSection]?
    
    
    //MARK: Initialization
    init(view: CommandsListTableViewControllerProtocol,
         models: [ACCommandsSection]? = ACAPIManager.parseCommandsSectionsJsonContent()) {
        self.models = models
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension CommandsListPresenter: CommandsListPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completionHandler: (([ACCommandsSection]) -> Void)) {
        view?.setupMainUI()
        completionHandler(models!)
    }
    
    internal func onShareRowAction(currentCommand: ACCommand) {
        let content =
        """
        \(currentCommand.name!)
        \(currentCommand.subtitle!)
        
        \(currentCommand.description!)
        """
        view?.presentActivityVC(activityItems: [content])
    }
    
    internal func onAdLooadFail() {
        view?.presentAdLoadFailedAlertController()
    }
    
    internal func onDidSelectRow(with indexPath: IndexPath) {
        /**
         Before we show the Screen with ads,
         we need to make sure that the user wants to view content that is beyond the limit(not in the `Operators` section).
         For this we will use the `sender` argument from the TableView.
         
         If it's not the first section(not the `Operators` section),
         then we show ads, but only then the Detail screen with the Article.
         In other cases, we immediately show the screen with the Article.
         */
//        switch indexPath.section {
//        case 0:
//            view?.presentDetailVC(for: indexPath)
//        default:
//            if ACNetworkManager.shared.isConnected {
//                view?.presentAdAlertController { [self] in
//                    view?.presentAdlnterstitial { [self] in
//                        view?.presentDetailVC(for: indexPath)
//                    }
//                }
//            } else {
//                view?.presentAdLoadFailedAlertController()
//            }
//        }
        view?.presentDetailVC(for: indexPath)
    }
    
    internal func onRemindRowAction(currentCommand: ACCommand) {
        if ACSettingsManager.shared.allowsNotifications {
            view?.presentReminderSetupAlert(with: currentCommand, completion: { date in
                if ACNotificationManager.shared.notificationsEnabled {
                    ACNotificationManager.shared.sendCommandNotification(with: currentCommand, for: date)
                    ACNotificationManager.shared.presentSuccesedNotificationSetAlert()
                } else {
                    ACNotificationManager.shared.presentFailedNotificationSetAlert()
                }
            })
        } else {
            ACGrayAlertManager.present(title: "Notifications Disabled", message: "You can unlock Notifications in the app's Settings.", duration: 8, preset: .custom(UIImage(systemName: "text.alignleft")!))
        }
    }
}

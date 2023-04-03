//
//  CommandsListPresenter.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.05.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension CommandsListPresenter {
    
    //MARK: Private
    enum Keys {
        
        //MARK: Static
        static let filteredSectionHeaderTitle: String = "Filtered Commands"
        static let filteredSectionHeaderHeight: Int = 40
    }
}


//MARK: - Commands List base completion Handler
typealias ACCommandsListBaseCompletionHandler = ([ACCommandsSection]) -> Void


//MARK: - Presenter protocol
internal protocol CommandsListPresenterProtocol {
    init(view: CommandsListTableViewControllerProtocol, manager: ACCommandsManagerProtocol)
    func onViewDidLoad(completionHandler: ACCommandsListBaseCompletionHandler)
    func filteredRowsWithScopes(for searchText: String, with scopeTitle: String) -> [ACCommandsSection]
    func onDidSelectRow(section: Int, row: Int)
    func onRemindRowAction(for command: ACCommand)
    func onShareRowAction(for command: ACCommand)
    func onDidFailPresentAd(with error: Error)
}


//MARK: - Main Presenter
final class CommandsListPresenter {
    
    //MARK: Private
    private weak var view: CommandsListTableViewControllerProtocol?
    private var manager: ACCommandsManagerProtocol
    
    
    //MARK: Initialization
    init(view: CommandsListTableViewControllerProtocol,
         manager: ACCommandsManagerProtocol = ACCommandsManager.shared) {
        self.manager = manager
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension CommandsListPresenter: CommandsListPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completionHandler: ACCommandsListBaseCompletionHandler) {
        view?.setupMainUI()
        completionHandler(manager.orderedCommandSections())
    }
    
    internal func onShareRowAction(for command: ACCommand) {
        let content = setupSharedContent(for: command)
        view?.presentActivityVC(activityItems: [content])
    }
    
    internal func onDidSelectRow(section: Int, row: Int) {
        /**
         Before we show the Screen with ads,
         we need to make sure that the user wants to view content that is beyond the limit(not in the `Operators` section).
         For this we will use the `sender` argument from the TableView.
         
         If it's not the first section(not the `Operators` section),
         then we show ads, but only then the Detail screen with the Article.
         In other cases, we immediately show the screen with the Article.
         */
        switch section {
        case 0:
            break
        default:
            view?.presentAdlnterstitial()
        }
        view?.presentDetailVC(section: section, row: row)
    }
    
    func onDidFailPresentAd(with error: Error) {
        view?.presentAdLoadFailAlertController(error: error)
    }
    
    internal func onRemindRowAction(for command: ACCommand) {
        if ACSettingsManager.shared.allowsNotifications {
            view?.presentReminderSetupAlert(with: command, completion: { date in
                if ACNotificationManager.shared.notificationsEnabled {
                    ACNotificationManager.shared.sendCommandNotification(with: command, for: date)
                    ACNotificationManager.shared.presentSuccesedNotificationSetAlert()
                } else {
                    ACNotificationManager.shared.presentFailedNotificationSetAlert()
                }
            })
        } else {
            view?.presentNotificationsDisabledAlert()
        }
    }
    
    /// This prepares a section with filtered by the user preferences commands.
    /// This section appears on the Commands List VC immediately after the user taps on the search bar.
    /// - Parameters:
    ///   - searchText: text that the user inputs into the search bar;
    ///   - scopeTitle: scope button title(segmented control under the search bar);
    /// - Returns: a section with filtered by the user preferences commands.
    internal func filteredRowsWithScopes(for searchText: String, with scopeTitle: String) -> [ACCommandsSection] {
        let name = Keys.filteredSectionHeaderTitle
        let headerHeight = Keys.filteredSectionHeaderHeight
        let filteredCommands = filteredCommands(by: scopeTitle, with: searchText)
        let filteredSection = [ACCommandsSection(
            name: name,
            footer: nil,
            headerHeight: headerHeight,
            commands: filteredCommands)
        ]
        return filteredSection
    }
}


//MARK: - Main methods
private extension CommandsListPresenter {
    
    //MARK: Private
    /// This prepares commands by their type using methods from the `ACCommandManager`
    /// and the text that the user enters into the searchBar.
    /// - Parameters:
    ///   - typeName: command type case rowvalue;
    ///   - searchText: text that the user inputs into the search bar;
    /// - Returns: an array of commands filtered by the user preferences.
    func filteredCommands(by typeName: String, with searchText: String) -> [ACCommand] {
        let neededRows: [ACCommand] = {
            switch typeName {
            case ACCommandType.all.rawValue:
                return manager.unfilteredCommands()
            case ACCommandType.libraries.rawValue:
                return manager.commandsFromLibraries()
            case ACCommandType.forDevices.rawValue:
                return manager.commandsForDevices()
            case ACCommandType.returns.rawValue:
                return manager.commandsThatReturn()
            default:
                return []
            }
        }()
        return neededRows.filter { row in
            let rowName = row.name.lowercased()
            let searchedText = searchText.lowercased()
            /**
             Before filtering, we need to lowercase the text user inputs because commands' names
             in the `commands` JSON file can start from capital letter or lowe case.
             */
            let searchedRow = rowName.contains(searchedText)
            return searchedRow
        }
    }
    
    /// This prepares the content for every basic `ACComand` model
    /// that will be shared via `UIActivityViewController`.
    /// - Parameters:
    ///   - command: a model from which a title, subtitle, and description for the result valur would be taken.
    /// - Returns: multiline string structure.
    func setupSharedContent(for command: ACCommand) -> String {
        return """
        \(command.name!)
        \(command.subtitle!)
        
        \(command.description!)
        """
    }
}

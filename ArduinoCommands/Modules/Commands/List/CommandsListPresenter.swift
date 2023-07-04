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
        static let filteredSectionHeaderHeight = 40
        static let filteredSectionHeaderTitle = "Filtered Commands"
    }
}


//MARK: - Commands List base completion Handler
typealias CommandsListUIBaseCompletionHandler = ([CommandsSectionUIModel]) -> Void


//MARK: - Presenter protocol
protocol CommandsListPresenterProtocol {
    init(view: CommandsListTableViewControllerProtocol, service: ACCommandsAPIClientProtocol)
    func onViewDidLoad(completionHandler: CommandsListUIBaseCompletionHandler)
    func filteredRowsWithScopes(for searchText: String, with scopeTitle: String) -> [CommandsSectionUIModel]
    func onRemindRowAction(for command: CommandUIModel)
    func onShareRowAction(for command: CommandUIModel)
    func onDidFailPresentAd(with error: Error)
    func onDidSelectRow(id: String)
}


//MARK: - Main Presenter
final class CommandsListPresenter {
    
    //MARK: Private
    private weak var view: CommandsListTableViewControllerProtocol?
    private var service: ACCommandsAPIClientProtocol!
    
    
    //MARK: Initialization
    init(view: CommandsListTableViewControllerProtocol,
         service: ACCommandsAPIClientProtocol = ACCommandsAPIClient(fileName: ACFilenames.commandsListFile)) {
        self.service = service
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension CommandsListPresenter: CommandsListPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completionHandler: CommandsListUIBaseCompletionHandler) {
        view?.setupMainUI()
        let sections = setupCommandsListSections()
        let uiSections = CommandsListFormatter.convert(sections)
        completionHandler(uiSections)
    }
    
    internal func onDidSelectRow(id: String) {
        ////**
        /// Before we show the Screen with ads,
        /// we need to make sure that the user wants to view content that is beyond the limit(not in the `Operators` section).
        /// For this we will use the `sender` argument from the TableView.
        ////*
        /// If it's not the first section (not the `Operators` section),
        /// then we show ads, but only then the Detail screen with the Article.
        /// In other cases, we immediately show the screen with the Article.
        /// */
        ///switch section {
        ///case 0:
        ///    break
        ///default:
        ///    view?.presentAdlnterstitial()
        ///}
        view?.presentDetailVC(with: selectModel(by: id)!)
    }
    
    internal func onDidFailPresentAd(with error: Error) {
        view?.presentAdLoadFailAlertController(error: error)
    }
    
    internal func onShareRowAction(for command: CommandUIModel) {
        guard let id = command.content else { return }
        guard let model = selectModel(by: id) else { return }
        let activityItems = [model.shared]
        view?.presentActivityVC(activityItems: activityItems)
    }
    
    internal func onRemindRowAction(for command: CommandUIModel) {
        if ACSettingsManager.shared.allowNotifications {
            view?.presentReminderSetupAlert(with: command, completion: { [self] date in
                guard let model = selectModel(by: command.content) else { return }
                let notificationsManager: ACNotificationManager = .shared
                if notificationsManager.notificationsEnabled {
                    notificationsManager.sendCommandNotification(with: model, date: date)
                    
                    ACGrayAlertManager.presentSuccesedNotificationSetAlert()
                } else {
                    ACGrayAlertManager.presentFailedNotificationSetAlert()
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
    ///   - scopeTitle: scope button title (segmented control under the search bar);
    /// - Returns: a section with filtered by the user preferences commands.
    internal func filteredRowsWithScopes(for searchText: String, with scopeTitle: String) -> [CommandsSectionUIModel] {
        let name = Keys.filteredSectionHeaderTitle
        let headerHeight = Keys.filteredSectionHeaderHeight
        let filteredCommands = filteredCommands(by: scopeTitle, with: searchText)
        let filteredSections = [ACCommandsSection(
            name: name,
            footer: nil,
            headerHeight: headerHeight,
            commands: filteredCommands)
        ]
        let filteredUISections = CommandsListFormatter.convert(filteredSections)
        return filteredUISections
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
                return service.unfilteredCommands()
            case ACCommandType.libraries.rawValue:
                return service.commandsFromLibraries()
            case ACCommandType.forDevices.rawValue:
                return service.commandsForDevices()
            case ACCommandType.returns.rawValue:
                return service.commandsThatReturn()
            default:
                return []
            }
        }()
        return neededRows.filter { row in
            let rowName = row.name.lowercased()
            let searchedText = searchText.lowercased()
            let searchedRow = rowName.contains(searchedText)
            return searchedRow
        }
    }
    
    /// This fetches command sections models and shows alert message if fetching failed.
    /// - Returns: a list of ordered command section models.
    func setupCommandsListSections() -> [ACCommandsSection] {
        let sections = service.orderedCommandSections()
        if  sections.isEmpty {
            view?.presentCommandsListLoadFailedAlert()
        }
        return sections
    }
    
    /// This finds the true Command model using its UI model.
    /// - Parameter id: identifier by which the model can be dermined.
    /// - Returns: Command model of type `ACCommand`.
    ///
    /// At the moment, identifier is a description of the command but, in the future,
    //TODO: Add special Command IDs to commands.json
    func selectModel(by id: String) -> ACCommand? {
        let models = service.unfilteredCommands()
        guard let model = models.first(where: { $0.description == id }) else { return nil }
        return model
    }
}

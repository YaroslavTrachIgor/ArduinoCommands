//
//  CommandsListTVController.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 03.05.2022.
//

import Foundation
import UserNotifications
import GoogleMobileAds
import SwiftUI
import UIKit
import Network

//MARK: - Main ViewController protocol
protocol CommandsListTableViewControllerProtocol: ACBaseWithShareViewController {
    func presentAdlnterstitial()
    func presentAdLoadFailAlertController(error: Error)
    func presentReminderSetupAlert(with command: CommandUIModel, completion: @escaping ((Date) -> Void))
    func presentNotificationsDisabledAlert()
    func presentCommandsListLoadFailedAlert()
    func presentDailyReadingProgressView()
    func presentDetailVC(with command: ACCommand)
}


//MARK: - Constants
private extension CommandsListTVController {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum SearchBar {
                
                //MARK: Static
                static let searchBarPlaceholder = "Search Commands"
            }
            enum Alert {
                enum ReminderAlert {
                    
                    //MARK: Static
                    static let title = "Select a Date \n for your Reminder"
                    static let message = "\n\n"
                    static let cancelActionTitle = "Cancel"
                    static let setDateActionTitle = "Select"
                    static let attributedTitleKeyPath = "attributedTitle"
                }
                enum CommandsListLoadFailedAlert {
                    
                    //MARK: Static
                    static let title = "Failed to load Commands List"
                    static let message = "An unexpected error occurred while loading the list of commands. Please try again later."
                }
                enum NotificationsDisabledAlert {
                    
                    //MARK: Static
                    static let title = "Notifications Disabled"
                    static let message = "You can unlock Notifications in the app's Settings."
                }
                enum AdErrorAlert {
                    
                    //MARK: Static
                    static let title = "Failed to load Ad"
                    static let message = "Detailed error code: "
                    static let cancelActionTitle = "Cancel"
                    static let presentAdActionTitle = "Watch"
                }
            }
            enum Image {
                
                //MARK: Static
                static let notifiactionsDisabledIconName = "text.alignleft"
                static let favoritesBarItemIconName = "text.badge.star"
                static let searchBarIconImageName = "magnifyingglass"
                static let backButtonImageName = "arrow.left"
                static let favoriteActionName = "star.fill"
                static let remindActionName = "app.badge"
                static let shareActionName = "square.and.arrow.up"
                static let dailyGoalIconName = "timer"
            }
            enum TableViewCell {
                
                //MARK: Static
                static let commandCellId = "CommandTableViewCell"
            }
            enum RowAction {
                
                //MARK: Static
                static let remindActionBackgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                static let shareActionBackgroundColor = #colorLiteral(red: 0.9974356294, green: 0.3451775312, blue: 0.3055633903, alpha: 1)
            }
        }
    }
}


//MARK: - Main ViewController
final class CommandsListTVController: UITableViewController, ACBaseViewController {

    //MARK: Private
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchBarEmpty: Bool { searchController.searchBar.text?.isEmpty ?? true }
    private var isFiltering: Bool { searchController.isActive && !isSearchBarEmpty }
    private var interstitial: GADInterstitialAd?
    private lazy var filteredSections = [CommandsSectionUIModel]()
    private var sections = [CommandsSectionUIModel]()
    
    private var presenter: CommandsListPresenterProtocol {
        return CommandsListPresenter(view: self)
    }
    private var adsClient: CommandsListAdsClientProtocol? {
        return CommandsListAdsClient()
    }
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.onViewDidLoad { rows in
            self.sections = rows
        }
    }

    //MARK: TableView protocols
    override func numberOfSections(in tableView: UITableView) -> Int {
        neededSections().count
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        neededSections()[section].footer
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        neededSections()[section].header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        neededSections()[section].commands.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let command = neededSections()[indexPath.section].commands[indexPath.row]
        let id = command.content
        presenter.onDidSelectRow(id: id!)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = neededSections()[section]
        let headerHeight = CGFloat(section.headerHeight)
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let command = neededSections()[indexPath.section].commands[indexPath.row]
        let actions = [setupShareRowAction(command: command)]
        let config = UISwipeActionsConfiguration(actions: actions)
        return config
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let command = neededSections()[indexPath.section].commands[indexPath.row]
        let actions = [setupRemindRowAction(command: command)]
        let config = UISwipeActionsConfiguration(actions: actions)
        return config
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellKey = Constants.UI.TableViewCell.commandCellId
        let cell: CommandsListTVCell = tableView.dequeueCell(cellKey, for: indexPath)
        let uiModel = neededSections()[indexPath.section].commands[indexPath.row]
        cell.configure(with: uiModel)
        return cell
    }
    
    //MARK: @objc
    @available(iOS 16.0, *)
    @objc func showDailyGoals() {
        presenter.onShowDailyGoals()
    }
}


//MARK: - ViewController protocol extension
extension CommandsListTVController: CommandsListTableViewControllerProtocol {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupTableView()
        setupInterstitial()
        setupNavigationBar()
        setupSearchController()
        setBlurViewForStatusBar()
        setupDailyGoalBarButtonItem()
        view.setupBasicMenuBackgroundView(.table)
    }
    
    internal func presentAdlnterstitial() {
        guard let interstitial = interstitial else { return }
        adsClient?.presentCommandDetailInterstitialAd(interstitial: interstitial, on: self)
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        let tintColor = Constants.UI.RowAction.shareActionBackgroundColor
        ACActivityManager.presentVC(activityItems: activityItems,
                                    tintColor: tintColor,
                                    on: self)
    }
    
    internal func presentCommandsListLoadFailedAlert() {
        let title = Constants.UI.Alert.CommandsListLoadFailedAlert.title
        let message = Constants.UI.Alert.CommandsListLoadFailedAlert.message
        ACAlertManager.shared.presentSimple(title: title,
                                            message: message,
                                            on: self)
    }
    
    internal func presentAdLoadFailAlertController(error: Error) {
        let errorDescription = String(describing: error)
        let title = Constants.UI.Alert.AdErrorAlert.title
        let message = Constants.UI.Alert.AdErrorAlert.message + errorDescription
        ACAlertManager.shared.presentSimple(title: title,
                                            message: message,
                                            on: self)
    }
    
    internal func presentNotificationsDisabledAlert() {
        let title = Constants.UI.Alert.NotificationsDisabledAlert.title
        let message = Constants.UI.Alert.NotificationsDisabledAlert.message
        let iconName = Constants.UI.Image.notifiactionsDisabledIconName
        let iconImage = UIImage(systemName: iconName)!
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   duration: 8,
                                   style: .iOS16AppleMusic)
    }
    
    internal func presentReminderSetupAlert(with command: CommandUIModel, completion: @escaping ((Date) -> Void)) {
        let remindActionBackColor = Constants.UI.RowAction.remindActionBackgroundColor
        let reminderDatePicker = setupReminderDatePicker()
        let title = Constants.UI.Alert.ReminderAlert.title
        let message = Constants.UI.Alert.ReminderAlert.message
        let attributedTitleKey = Constants.UI.Alert.ReminderAlert.attributedTitleKeyPath
        let cancelActionTitle = Constants.UI.Alert.ReminderAlert.cancelActionTitle
        let setDateActionTitle = Constants.UI.Alert.ReminderAlert.setDateActionTitle
        let titleFont = UIFont.ACFont(ofSize: 14, weight: .bold)
        let titleAttributes = [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .default)
        let setDateAction = UIAlertAction(title: setDateActionTitle, style: .cancel, handler: { _ in
            completion(reminderDatePicker.date)
        })
        alertController.view.tintColor = remindActionBackColor
        alertController.addAction(setDateAction)
        alertController.addAction(cancelAction)
        alertController.setValue(attributedTitle, forKeyPath: attributedTitleKey)
        alertController.view.addSubview(reminderDatePicker)
        present(alertController, animated: true, completion: nil)
    }
    
    internal func presentDailyReadingProgressView() {
        if #available(iOS 16.0, *) {
            let rootView = DailyReadingProgressView(isOpenedFromSettings: false)
            let analyticsView = UIHostingController(rootView: rootView)
            presentSheet(with: analyticsView, detents: [.custom { _ in return 490 }])
        }
    }
    
    internal func presentDetailVC(with model: ACCommand) {
        let detailVC: CommandDetailViewController = .instantiate()
        detailVC.model = model
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: - Main methods
private extension CommandsListTVController {
    
    //MARK: Privat
    func setupNavigationBar() {
        let font = UIFont.ACFont(ofSize: 16.0, weight: .bold)
        let titleFontAttributes = [NSAttributedString.Key.font: font]
        let backIndicatorImageName = Constants.UI.Image.backButtonImageName
        let backIndicatorImage = UIImage.init(systemName: backIndicatorImageName)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backIndicatorImage
        navigationController?.navigationBar.backIndicatorImage = backIndicatorImage
        navigationController?.navigationBar.titleTextAttributes = titleFontAttributes
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.backItem?.title = nil
    }
    
    func setupSearchController() {
        let scopeButtonTitles = ACCommandType.allNames
        let placeholder = Constants.UI.SearchBar.searchBarPlaceholder
        let iconName = Constants.UI.Image.searchBarIconImageName
        let iconImageConfig = UIImage.SymbolConfiguration(weight: .regular)
        let iconImage = UIImage(systemName: iconName, withConfiguration: iconImageConfig)
        searchController.searchBar.searchTextField.leftView?.tintColor = .tertiaryLabel
        searchController.searchBar.setImage(iconImage, for: .search, state: .normal)
        searchController.searchBar.searchTextField.textAlignment = .left
        searchController.searchBar.tintColor = .label
        searchController.searchBar.placeholder = placeholder
        searchController.searchBar.scopeButtonTitles = scopeButtonTitles
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupTableView() {
        let backgroundColor = view.backgroundColor
        let separatorColor: UIColor = .separator.withAlphaComponent(0.14)
        tableView.backgroundColor = backgroundColor
        tableView.allowsMultipleSelection = false
        tableView.sectionHeaderTopPadding = .leastNonzeroMagnitude
        tableView.dragInteractionEnabled = true
        tableView.sectionHeaderHeight = 0
        tableView.allowsSelection = true
        tableView.separatorColor = separatorColor
        tableView.rowHeight = 145
        tableView.isEditing = false
    }
    
    func setupReminderDatePicker() -> UIDatePicker {
        let remindActionBackColor = Constants.UI.RowAction.remindActionBackgroundColor
        let reminderDatePicker = UIDatePicker()
        reminderDatePicker.timeZone = NSTimeZone.local
        reminderDatePicker.frame = CGRect(x: -15, y: 55, width: 270, height: 60)
        reminderDatePicker.tintColor = remindActionBackColor
        return reminderDatePicker
    }
    
    func setupDailyGoalBarButtonItem() {
        if #available(iOS 16.0, *) {
            let action = #selector(showDailyGoals)
            let dailyGoalIconName = Constants.UI.Image.dailyGoalIconName
            let dailyGoalIconImageConfiguration = UIImage.SymbolConfiguration(pointSize: 15.5, weight: .regular, scale: .unspecified)
            let dailyGoalIconImageView = UIImage(systemName: dailyGoalIconName)?.applyingSymbolConfiguration(dailyGoalIconImageConfiguration)
            let dailyGoalBarButtonItem = UIBarButtonItem(image: dailyGoalIconImageView, style: .plain, target: self, action: action)
            navigationItem.leftBarButtonItem = dailyGoalBarButtonItem
        }
    }
    
    func setupShareRowAction(command: CommandUIModel) -> UIContextualAction {
        let shareActionBackColor = Constants.UI.RowAction.shareActionBackgroundColor
        let shareActionIconName = Constants.UI.Image.shareActionName
        let shareAction = UIContextualAction(style: .normal, title: nil) { [self] _, _, _ in
            presenter.onShareRowAction(for: command)
        }
        shareAction.backgroundColor = shareActionBackColor
        shareAction.image = UIImage(systemName: shareActionIconName,
                                    withConfiguration: setupBasicCellContextMenuImageIcon())
        return shareAction
    }
    
    func setupRemindRowAction(command: CommandUIModel) -> UIContextualAction {
        let remindActionBackColor = Constants.UI.RowAction.remindActionBackgroundColor
        let remindActionIconName = Constants.UI.Image.remindActionName
        let remindAction = UIContextualAction(style: .normal, title: nil) { [self] _, _, _ in
            presenter.onRemindRowAction(for: command)
        }
        remindAction.backgroundColor = remindActionBackColor
        remindAction.image = UIImage(systemName: remindActionIconName,
                                     withConfiguration: setupBasicCellContextMenuImageIcon())
        return remindAction
    }
    
    func setupInterstitial() {
        adsClient?.setupCommandDetailInterstitialAd(delegate: self, completion: { interstitial in
            self.interstitial = interstitial
            self.interstitial?.fullScreenContentDelegate = self
        })
    }
    
    
    //MARK: Fast methods
    func neededSections() -> [CommandsSectionUIModel] {
        if isFiltering {
            return filteredSections
        } else {
            return sections
        }
    }
    
    func setupBasicCellContextMenuImageIcon() -> UIImage.SymbolConfiguration {
        return UIImage.SymbolConfiguration(pointSize: 0,
                                           weight: .regular,
                                           scale: .large)
    }
}


//MARK: - SearchResultsUpdating protocol
extension CommandsListTVController: UISearchResultsUpdating {
    
    //MARK: Internal
    internal func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        let scopeIndex = searchBar.selectedScopeButtonIndex
        let scopeTitle = searchBar.scopeButtonTitles![scopeIndex]
        let filteredSection = presenter.filteredRowsWithScopes(for: searchText, with: scopeTitle)
        filteredSections = filteredSection
        tableView.reloadData()
    }
}


//MARK: - GAD Delegate protocol extension
extension CommandsListTVController: GADFullScreenContentDelegate {
    
    //MARK: Internal
    internal func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {}
}

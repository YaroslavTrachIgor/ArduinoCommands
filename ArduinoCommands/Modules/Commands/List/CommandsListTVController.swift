//
//  CommandsListTVController.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 03.05.2022.
//

import Foundation
import UserNotifications
import GoogleMobileAds
import UIKit
import Network

//MARK: - Keys
private extension CommandsListTVController {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Segues {
               
                //MARK: Static
                static let detail = "CommandDetailSegue"
            }
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
                enum AdAlert {
                    
                    //MARK: Static
                    static let title = "Articles Limit"
                    static let message = "Articles which are not in the Operators section are available only in the Paid version of Arduino Commands. You can watch the Advertisement and read the Article you need."
                    static let cancelActionTitle = "Cancel"
                    static let presentAdActionTitle = "Watch"
                }
            }
            enum Image {
                
                //MARK: Static
                static let favoritesBarItemIconName = "text.badge.star"
                static let searchBarIconImageName = "magnifyingglass"
                static let backButtonImageName = "arrow.left"
                static let favoriteActionName = "star.fill"
                static let remindActionName = "app.badge"
                static let shareActionName = "square.and.arrow.up"
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


//MARK: - Main commands list ViewController
final class CommandsListTVController: UITableViewController, ACBaseViewController {

    //MARK: Private
    private let adsManager = ACGoogleAdsManagar.shared
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchBarEmpty: Bool { searchController.searchBar.text?.isEmpty ?? true }
    private var isFiltering: Bool { searchController.isActive && !isSearchBarEmpty }
    private lazy var filteredSections = [ACCommandsSection]()
    private var sections = [ACCommandsSection]() 
    private var presenter: CommandsListPresenterProtocol {
        CommandsListPresenter(view: self)
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
        neededSections()[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        neededSections()[section].commands.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onDidSelectRow(with: indexPath)
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
        let cellKey = Keys.UI.TableViewCell.commandCellId
        let cell = tableView.dequeueReusableCell(withIdentifier: cellKey, for: indexPath) as! CommandsListTVCell
        let row = indexPath.row
        let section = indexPath.section
        let model = neededSections()[section].commands[row]
        let viewModel = CommandsListTVCellUIModel(model: model)
        cell.configure(with: viewModel)
        return cell
    }
}


//MARK: - Base ViewController protocol extension
extension CommandsListTVController: ACBaseCommandsListTableViewController {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupView()
        setupTableView()
        setupNavigationBar()
        setupSearchController()
        setBlurViewForStatusBar()
    }
    
    internal func presentAdLoadFailedAlertController() {
        adsManager.rootViewController = self
        adsManager.presentAdLoadFailedAlertController()
    }
    
    internal func presentAdlnterstitial(completion: @escaping (() -> Void)) {
        adsManager.rootViewController = self
        adsManager.setupCommandDetailnterstitialAd(delegate: self)
        adsManager.presentCommandDetailnterstitialAd {
            completion()
        }
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        let tintColor = Keys.UI.RowAction.shareActionBackgroundColor
        ACActivityManager.presentVC(activityItems: activityItems,
                                    tintColor: tintColor,
                                    on: self)
    }
    
    internal func presentAdAlertController(completion: @escaping (() -> Void)) {
        let title = Keys.UI.Alert.AdAlert.title
        let message = Keys.UI.Alert.AdAlert.message
        let actionTitle = Keys.UI.Alert.AdAlert.presentAdActionTitle
        ACAlertManager.shared.presentSimpleWithAction(title: title,
                                                      message: message,
                                                      actionTitle: actionTitle,
                                                      actionHandler: { _ in
            completion()
        }, on: self)
    }
    
    internal func presentDetailVC(for indexPath: IndexPath) {
        let detailVC = CommandDetailViewController.instantiate()
        let section = indexPath.section
        let row = indexPath.row
        let model = neededSections()[section].commands[row]
        detailVC.model = model
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: - Main methods
private extension CommandsListTVController {
    
    //MARK: Private
    func setupView() {
        view.alpha = 1
        view.tintColor = .label
        view.backgroundColor = .systemGroupedBackground
    }
    
    func setupNavigationBar() {
        let font = UIFont.ACFont(ofSize: 16.0, weight: .bold)
        let titleFontAttributes = [NSAttributedString.Key.font: font]
        let backIndicatorImageName = Keys.UI.Image.backButtonImageName
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
        let placeholder = Keys.UI.SearchBar.searchBarPlaceholder
        let iconName = Keys.UI.Image.searchBarIconImageName
        let iconImageConfig = UIImage.SymbolConfiguration(weight: .regular)
        let iconImage = UIImage(systemName: iconName, withConfiguration: iconImageConfig)
        searchController.searchBar.searchTextField.leftView?.tintColor = .tertiaryLabel
        searchController.searchBar.setImage(iconImage, for: .search, state: .normal)
        searchController.searchBar.searchTextField.textAlignment = .left
        searchController.searchBar.tintColor = .label
        searchController.searchBar.placeholder = placeholder
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        
        searchController.searchBar.scopeButtonTitles = ["All", "For Devices", "Returns", "Libraries"]
    
        
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
        let remindActionBackColor = Keys.UI.RowAction.remindActionBackgroundColor
        let reminderDatePicker = UIDatePicker()
        reminderDatePicker.timeZone = NSTimeZone.local
        reminderDatePicker.frame = CGRect(x: -15, y: 55, width: 270, height: 60)
        reminderDatePicker.tintColor = remindActionBackColor
        return reminderDatePicker
    }
    
    func presentReminderSetupAlert(with command: ACCommand, completion: @escaping ((Date) -> Void)) {
        let remindActionBackColor = Keys.UI.RowAction.remindActionBackgroundColor
        let reminderDatePicker = setupReminderDatePicker()
        let title = Keys.UI.Alert.ReminderAlert.title
        let message = Keys.UI.Alert.ReminderAlert.message
        let attributedTitleKey = Keys.UI.Alert.ReminderAlert.attributedTitleKeyPath
        let cancelActionTitle = Keys.UI.Alert.ReminderAlert.cancelActionTitle
        let setDateActionTitle = Keys.UI.Alert.ReminderAlert.setDateActionTitle
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
    
    func setupShareRowAction(command: ACCommand) -> UIContextualAction {
        let shareActionBackColor = Keys.UI.RowAction.shareActionBackgroundColor
        let shareActionIconName = Keys.UI.Image.shareActionName
        let shareAction = UIContextualAction(style: .normal, title: nil) { [self] _, _, _ in
            presenter.onShareRowAction(currentCommand: command)
        }
        shareAction.backgroundColor = shareActionBackColor
        shareAction.image = UIImage(systemName: shareActionIconName,
                                    withConfiguration: setupBasicCellContextMenuImageIcon())
        return shareAction
    }
    
    func setupRemindRowAction(command: ACCommand) -> UIContextualAction {
        let remindActionBackColor = Keys.UI.RowAction.remindActionBackgroundColor
        let remindActionIconName = Keys.UI.Image.remindActionName
        let remindAction = UIContextualAction(style: .normal, title: nil) { [self] _, _, _ in
            presentReminderSetupAlert(with: command, completion: { [self] date in
                presenter.onRemindRowAction(currentCommand: command, for: date)
            })
        }
        remindAction.backgroundColor = remindActionBackColor
        remindAction.image = UIImage(systemName: remindActionIconName,
                                     withConfiguration: setupBasicCellContextMenuImageIcon())
        return remindAction
    }
    
    //MARK: Fast methods
    func neededSections() -> [ACCommandsSection] {
        if isFiltering {
            return filteredSections
        } else {
            return sections
        }
    }
    
    func filterSections(for searchBar: UISearchBar!) {
        var rows: [ACCommand] = .init()
        for section in sections {
            for command in section.commands {
                rows.append(command)
            }
        }
        
        let neededRows: [ACCommand] = {
            let scopeTitle = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
            switch scopeTitle {
            case "All":
                return rows
            case "Libraries":
                var libraryRows: [ACCommand] = .init()
                for row in rows {
                    if row.isLibraryMethod {
                        libraryRows.append(row)
                    }
                }
                return libraryRows
            case "For Devices":
                var forDevices: [ACCommand] = .init()
                for row in rows {
                    if row.isUsedWithDevices {
                        forDevices.append(row)
                    }
                }
                return forDevices
            case "Returns":
                var functions: [ACCommand] = .init()
                for row in rows {
                    if row.returns {
                        functions.append(row)
                    }
                }
                return functions
            default:
                return []
            }
        }()
        
        
        let filteredCommands = neededRows.filter { row in
            let content = row.name!.lowercased()
            let searchedContent = searchBar.text!.lowercased()
            let filteredContent = content.contains(searchedContent)
            return filteredContent
        }
        filteredSections = [ACCommandsSection(name: "Filtered Commands", footer: nil, headerHeight: 40, commands: filteredCommands)]
        tableView.reloadData()
    }
    
    func setupBasicCellContextMenuImageIcon() -> UIImage.SymbolConfiguration {
        return UIImage.SymbolConfiguration(pointSize: 0, weight: .regular, scale: .large)
    }
}


//MARK: SearchResultsUpdating protocol
extension CommandsListTVController: UISearchResultsUpdating {
    
    //MARK: Internal
    internal func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterSections(for: searchBar)
    }
}


//MARK: GAD Delegate protocol extension
extension CommandsListTVController: GADFullScreenContentDelegate {
    
    //MARK: Internal
    internal func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        presenter.onAdLooadFail()
    }
}

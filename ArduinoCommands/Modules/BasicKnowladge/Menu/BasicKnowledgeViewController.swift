//
//  BasicKnowledgeViewController.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 13.03.2022.
//

import Foundation
import UIKit
import SafariServices
import SPAlert
import SwiftUI

//MARK: - Keys
private extension BasicKnowledgeViewController {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Segues {
                
                //MARK: Static
                static let detail = "DetailSegue"
            }
            enum Label {
                
                //MARK: Static
                static let tableHeader = "Resources"
                static let tableFooter = "Arduino Commands © 2022 \n All rights reserved."
            }
            enum CollectionView {
                enum CellKeys {
                    
                    //MARK: Static
                    static let basicsSectionCellKey = "BasicKnowladgeCollectionCell"
                    static let usersSectionCellKey = "UserCollectionViewCell"
                    static let teamSectionCellKey = "PersonCollectionViewCell"
                    static let siteSectionCellKey = "SiteCollectionViewCell"
                }
                enum CellSpacing {
                    
                    //MARK: Static
                    static let insetForBasicsSection = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 50)
                    static let insetForSitesSection = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 50)
                    static let insetForUsersSection = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 70)
                    static let insetForTeamSection = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 50)
                }
                enum CellSize {
                    
                    //MARK: Static
                    static let sizeForItemAtBasicsSection = CGSize(width: 180, height: 285)
                    static let sizeForItemAtSitesSection = CGSize(width: 230, height: 90)
                    static let sizeForItemAtUsersSection = CGSize(width: 90, height: 115)
                    static let sizeForItemAtTeamSection = CGSize(width: 240, height: 185)
                }
                enum MinimumSpacings {
                    
                    //MARK: Static
                    static let minimumLineSpacing: CGFloat = 20
                    static let minimumInteritemSpacing: CGFloat = 0
                }
            }
        }
    }
}


//MARK: - Main menu ViewController
final class BasicKnowledgeViewController: UITableViewController, ACBaseViewController {
    
    //MARK: Private
    private let defaults = UserDefaults.standard
    private var sections = [BasicKnowledgeSectionRow]()
    private var presenter: BasicKnowledgePresenterProtocol? {
        return BasicKnowledgePresenter(view: self)
    }
    
    //MARK: @IBOutlets
    @IBOutlet private weak var basicsCollectionView: UICollectionView!
    @IBOutlet private weak var sitesCollectionView: UICollectionView!
    @IBOutlet private weak var usersCollectionView: UICollectionView!
    @IBOutlet private weak var teamCollectionView: UICollectionView!
    @IBOutlet private weak var footerLabel: UILabel!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onOnboardingPresent()
        presenter?.onViewDidLoad(completion: { sections in
            self.sections = sections
        })
    }
    
    //MARK: TableView protocols
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        setupBasicsHeaderView()
    }
    
    //MARK: @IBActions
    @IBAction func presentSettingsHostVC(_ sender: Any) {
        presenter?.onPresentSettingsHostVC()
    }
    
    //MARK: Base ViewController logic protocol
    internal func setupMainUI() {
        setupView()
        setupTableView()
        setupNavigationBar()
        setupSectionsUI()
        setupFooterLabel()
        setBlurViewForStatusBar()
    }
}


//MARK: - Base ViewController protocol extension
extension BasicKnowledgeViewController: ACBaseBasicKnowledgeVCProtocol {
    
    //MARK: Internal
    internal func presentSettingsHostVC() {
        let settingsState = SettingsStateHelper()
        let rootView = SettingsView().environmentObject(settingsState)
        let controller = UIHostingController(rootView: rootView)
        presentSheet(with: controller)
    }
    
    internal func presentOnboardingVC() {
        let vc = OnboardingViewController()
        presentSheet(with: vc, detents: [.large()])
    }
    
    internal func presentSiteWithSafari(with data: ACLink) {
        let stringURL = data.link!
        presentSafariVC(for: stringURL)
    }
    
    internal func presentUserSheetVC(with data: ACUser) {
        let usersSheetVC = UserSheetTVController.instantiate()
        usersSheetVC.model = data
        presentSheet(with: usersSheetVC, detents: [.medium()])
    }
    
    internal func presentDetailVC(with data: ACBasics) {
        let detailVC = BasicKnowledgeDetailViewController.instantiate()
        detailVC.model = data
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: - CollectionView protocols
extension BasicKnowledgeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Internal
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[collectionView.tag]
        switch section {
        case .basics(let rows):
            return rows.count
        case .team(let rows):
            return rows.count
        case .links(let rows):
            return rows.count
        case .users(let rows):
            return rows.count
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let section = sections[collectionView.tag]
        switch section {
        case .basics(let rows):
            let key = Keys.UI.CollectionView.CellKeys.basicsSectionCellKey
            let cell = basicsCollectionView.dequeueReusableCell(withReuseIdentifier: key, for: indexPath) as! BasicsCollectionViewCell
            let uiModel = BasicsCellUIModel(model: rows[row])
            cell.configure(with: uiModel)
            return cell
        case .team(let rows):
            let key = Keys.UI.CollectionView.CellKeys.teamSectionCellKey
            let cell = teamCollectionView.dequeueReusableCell(withReuseIdentifier: key, for: indexPath) as! PersonCollectionViewCell
            let uiModel = PersonCellUIModel(model: rows[row])
            cell.configure(with: uiModel)
            return cell
        case .links(let rows):
            let key = Keys.UI.CollectionView.CellKeys.siteSectionCellKey
            let cell = sitesCollectionView.dequeueReusableCell(withReuseIdentifier: key, for: indexPath) as! SiteCollectionViewCell
            let uiModel = SiteCellUIModel(model: rows[row])
            cell.configure(with: uiModel)
            return cell
        case .users(let rows):
            let key = Keys.UI.CollectionView.CellKeys.usersSectionCellKey
            let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: key, for: indexPath) as! UserCollectionViewCell
            let uiModel = UserCellUIModel(model: rows[row])
            cell.configure(with: uiModel)
            return cell
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = sections[collectionView.tag]
        switch section {
        case .basics(_):
            return Keys.UI.CollectionView.CellSpacing.insetForBasicsSection
        case .team(_):
            return Keys.UI.CollectionView.CellSpacing.insetForTeamSection
        case .links(_):
            return Keys.UI.CollectionView.CellSpacing.insetForSitesSection
        case .users(_):
            return Keys.UI.CollectionView.CellSpacing.insetForUsersSection
        }
    }

    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = sections[collectionView.tag]
        switch section {
        case .basics(_):
            return Keys.UI.CollectionView.CellSize.sizeForItemAtBasicsSection
        case .team(_):
            return Keys.UI.CollectionView.CellSize.sizeForItemAtTeamSection
        case .links(_):
            return Keys.UI.CollectionView.CellSize.sizeForItemAtSitesSection
        case .users(_):
            return Keys.UI.CollectionView.CellSize.sizeForItemAtUsersSection
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Keys.UI.CollectionView.MinimumSpacings.minimumInteritemSpacing
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Keys.UI.CollectionView.MinimumSpacings.minimumLineSpacing
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.onDidSelectItemAt(for: collectionView.tag, with: indexPath.row)
    }
}


//MARK: - Main methods
private extension BasicKnowledgeViewController {
    
    //MARK: Private
    func setupView() {
        view.alpha = 1
        view.tintColor = .label
        view.backgroundColor = .systemGroupedBackground
    }
    
    func setupNavigationBar() {
        let font = UIFont.ACFont(ofSize: 16.0, weight: .bold)
        let titleFontAttributes = [NSAttributedString.Key.font: font]
        navigationController?.navigationBar.titleTextAttributes = titleFontAttributes
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.barStyle = .default
    }
    
    func setupTableView() {
        tableView.alpha = 1
        tableView.isEditing = false
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
        tableView.sectionHeaderTopPadding = .leastNormalMagnitude
        tableView.dragInteractionEnabled = true
        tableView.sectionHeaderHeight = 0
        tableView.backgroundColor = .secondarySystemBackground
    }
    
    func setupSectionsUI() {
        /**
         To quickly prepare the basic collectionView properties,
         we will use `setupBasicCollectionView(...)` for every row collectionView.
         
         A unique tag will be passed to the argument
         to make it easier to prepare different collectionView properties
         in `UICollectionView` life cycle functions which passes `indexPath` argument.
         */
        setupBasicCollectionView(with: basicsCollectionView, tag: 0)
        setupBasicCollectionView(with: sitesCollectionView, tag: 2)
        setupBasicCollectionView(with: usersCollectionView, tag: 3)
        setupBasicCollectionView(with: teamCollectionView, tag: 1)
    }
    
    func setupFooterLabel() {
        let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        let content = Keys.UI.Label.tableFooter
        footerLabel.backgroundColor = .secondarySystemBackground
        footerLabel.numberOfLines = 0
        footerLabel.textColor = .tertiaryLabel
        footerLabel.text = content
        footerLabel.font = font
    }
    
    func setupBasicCollectionView(with collectionView: UICollectionView, tag: Int) {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = tag
    }
    
    func setupBasicsHeaderView() -> UIView {
        let tableViewWidth = self.tableView.frame.width
        let viewFrame = CGRect.init(x: 0, y: 0, width: tableViewWidth, height: 70)
        let headerView = UIView.init(frame: viewFrame)
        let headerLabel = setupBasicsHeaderLabel(with: headerView)
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func setupBasicsHeaderLabel(with headerView: UIView) -> UILabel {
        let labelFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        let content = Keys.UI.Label.tableHeader.uppercased()
        let labelWidth = headerView.frame.width - 10
        let labelHeight = headerView.frame.height - 10
        let labelFrame = CGRect.init(x: 30, y: -5, width: labelWidth, height: labelHeight)
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.frame = labelFrame
        label.font = labelFont
        label.text = content
        return label
    }
}

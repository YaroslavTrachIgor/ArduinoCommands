//
//  BasicKnowledgeViewController.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 13.03.2022.
//

import Foundation
import UIKit
import GoogleMobileAds
import SafariServices
import SwiftUI
import TipKit

//MARK: - Main ViewController protocol
protocol BasicKnowledgeVCProtocol: ACBaseViewController {
    func presentSettingsTip()
    func presentOnboardingVC()
    func presentSettingsHostVC()
    func presentAdlnterstitial()
    func presentDetailVC(with model: ACBasics)
    func presentUserSheetVC(with model: ACUser)
    func presentSiteWithSafari(with model: ACLink)
}


//MARK: - Constants
private extension BasicKnowledgeViewController {
    
    //MARK: Private
    enum Constants {
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
                    static let insetForBasicsSection = UIEdgeInsets(top: 16, left: 22, bottom: 10, right: 35)
                    static let insetForSitesSection = UIEdgeInsets(top: 16, left: 15, bottom: 10, right: 35)
                    static let insetForUsersSection = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 70)
                    static let insetForTeamSection = UIEdgeInsets(top: 16, left: 22, bottom: 10, right: 35)
                }
                enum CellSize {
                    
                    //MARK: Static
                    static let sizeForItemAtBasicsSection = CGSize(width: 190, height: 250)
                    static let sizeForItemAtSitesSection = CGSize(width: 238, height: 80)
                    static let sizeForItemAtUsersSection = CGSize(width: 90, height: 115)
                    static let sizeForItemAtTeamSection = CGSize(width: 270, height: 108)
                }
                enum MinimumSpacings {
                    
                    //MARK: Static
                    static let minimumHeaderHeight: CGFloat = 10
                    static let minimumLineSpacing: CGFloat = 30
                    static let minimumInteritemSpacing: CGFloat = 0
                }
            }
        }
    }
}


//MARK: - Main ViewController
final class BasicKnowledgeViewController: UITableViewController, ACBaseViewController {
    
    //MARK: Private
    private let defaults = UserDefaults.standard
    private var sections = [BasicKnowledgeSectionRow]()
    private var interstitial: GADInterstitialAd?
    private var presenter: BasicKnowledgePresenterProtocol? {
        return BasicKnowledgePresenter(view: self)
    }
    private var adsClient: BasicKnowledgeAdsClientProtocol? {
        return BasicKnowledgeAdsClient()
    }
    
    //MARK: @IBOutlets
    @IBOutlet private weak var settingsBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var basicsCollectionView: UICollectionView!
    @IBOutlet private weak var sitesCollectionView: UICollectionView!
    @IBOutlet private weak var usersCollectionView: UICollectionView!
    @IBOutlet private weak var teamCollectionView: UICollectionView!
    @IBOutlet private weak var footerLabel: UILabel!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad(completion: { sections in
            self.sections = sections
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.onViewDidAppear()
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
        setupTableView()
        setupNavigationBar()
        setupSectionsUI()
        setupFooterLabel()
        setupInterstitial()
        setBlurViewForStatusBar()
        view.setupBasicMenuBackgroundView(.secondary)
    }
}


//MARK: - ViewController protocol extension
extension BasicKnowledgeViewController: BasicKnowledgeVCProtocol {
    
    //MARK: Internal
    internal func presentSettingsHostVC() {
        let rootView = SettingsView()
        let controller = UIHostingController(rootView: rootView)
        presentSheet(with: controller)
    }
    
    internal func presentSiteWithSafari(with data: ACLink) {
        let stringURL = data.link!
        presentSafariVC(for: stringURL)
    }
    
    internal func presentAdlnterstitial() {
        guard let interstitial = interstitial else { return }
        adsClient?.presentBasicKnowledgeDetailInterstitialAd(interstitial: interstitial, on: self)
    }
    
    internal func presentUserSheetVC(with data: ACUser) {
        let usersSheetVC = UserSheetListController.instantiate()
        usersSheetVC.model = data
        presentSheet(with: usersSheetVC, detents: [.medium()])
    }
    
    internal func presentSettingsTip() {
        if #available(iOS 17.0, *) {
            Task { @MainActor in
                let tip = BasicKnowledgeSettingsTip()
                let tipViewStyle = BasicKnowledgeSettingsTipViewStyle()
                let controller = TipUIPopoverViewController(tip, sourceItem: settingsBarButtonItem)
                controller.viewStyle = tipViewStyle
                present(controller, animated: true)
            }
        }
    }
    
    internal func presentOnboardingVC() {
        if #available(iOS 16.0, *) {
            let onboardingView = OnboardingView()
            let onboardingViewController = UIHostingController(rootView: onboardingView)
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: true)
        }
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
            let key = Constants.UI.CollectionView.CellKeys.basicsSectionCellKey
            let cell: BasicsCollectionViewCell = basicsCollectionView.dequeueCell(key, for: indexPath)
            let uiModel = BasicsCellUIModel(model: rows[row])
            cell.configure(with: uiModel)
            return cell
        case .team(let rows):
            let key = Constants.UI.CollectionView.CellKeys.teamSectionCellKey
            let cell: PersonCollectionViewCell = teamCollectionView.dequeueCell(key, for: indexPath)
            let uiModel = PersonCellUIModel(model: rows[row])
            cell.configure(with: uiModel)
            return cell
        case .links(let rows):
            let key = Constants.UI.CollectionView.CellKeys.siteSectionCellKey
            let cell: SiteCollectionViewCell = sitesCollectionView.dequeueCell(key, for: indexPath)
            let uiModel = SiteCellUIModel(model: rows[row])
            cell.configure(with: uiModel)
            return cell
        case .users(let rows):
            let key = Constants.UI.CollectionView.CellKeys.usersSectionCellKey
            let cell: UserCollectionViewCell = usersCollectionView.dequeueCell(key, for: indexPath)
            let uiModel = UserCellUIModel(model: rows[row])
            cell.configure(with: uiModel)
            return cell
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = sections[collectionView.tag]
        switch section {
        case .basics(_):
            return Constants.UI.CollectionView.CellSpacing.insetForBasicsSection
        case .team(_):
            return Constants.UI.CollectionView.CellSpacing.insetForTeamSection
        case .links(_):
            return Constants.UI.CollectionView.CellSpacing.insetForSitesSection
        case .users(_):
            return Constants.UI.CollectionView.CellSpacing.insetForUsersSection
        }
    }

    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = sections[collectionView.tag]
        switch section {
        case .basics(_):
            return Constants.UI.CollectionView.CellSize.sizeForItemAtBasicsSection
        case .team(_):
            return Constants.UI.CollectionView.CellSize.sizeForItemAtTeamSection
        case .links(_):
            return Constants.UI.CollectionView.CellSize.sizeForItemAtSitesSection
        case .users(_):
            return Constants.UI.CollectionView.CellSize.sizeForItemAtUsersSection
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.UI.CollectionView.MinimumSpacings.minimumInteritemSpacing
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.UI.CollectionView.MinimumSpacings.minimumLineSpacing
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.UI.CollectionView.MinimumSpacings.minimumHeaderHeight
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.onDidSelectItemAt(for: collectionView.tag, with: indexPath.row)
    }
}


//MARK: - Main methods
private extension BasicKnowledgeViewController {
    
    //MARK: Private
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
    
    func setupInterstitial() {
        adsClient?.setupBasicKnowledgeDetailInterstitialAd(delegate: self, completion: { interstitial in
            self.interstitial = interstitial
            self.interstitial?.fullScreenContentDelegate = self
        })
    }
    
    func setupFooterLabel() {
        let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        let content = Constants.UI.Label.tableFooter
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
        let content = Constants.UI.Label.tableHeader.uppercased()
        let textColor = UIColor.secondaryLabel
        let labelFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        let labelWidth = headerView.frame.width - 10
        let labelHeight = headerView.frame.height - 10
        let labelFrame = CGRect.init(x: 32, y: -8, width: labelWidth, height: labelHeight)
        let label = UILabel()
        label.textColor = textColor
        label.frame = labelFrame
        label.font = labelFont
        label.text = content
        return label
    }
}


//MARK: - GAD Delegate protocol extension
extension BasicKnowledgeViewController: GADFullScreenContentDelegate {
    
    //MARK: Internal
    internal func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {}
}

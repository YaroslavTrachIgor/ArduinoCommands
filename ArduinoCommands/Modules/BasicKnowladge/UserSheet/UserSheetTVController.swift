//
//  UsersSheetTableVC.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 21.03.2022.
//

import Foundation
import UIKit

//MARK: - Constants
private extension UserSheetTVController {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Label {
                
                //MARK: Static
                static let headerLabelContent = "Our Team"
            }
            enum TableViewCell {
                
                //MARK: Static
                static let userSheetCellKey = "UserSheetTableViewCell"
            }
            enum TableView {
                
                //MARK: Static
                static let rowHeight: CGFloat = 400
                static let sectionHeaderHeight: CGFloat = 30
                static let numberOfSections: Int = 1
            }
        }
    }
}


//MARK: - Main User profile sheet TableViewController
final class UserSheetTVController: UITableViewController, ACBaseStoryboarded {
    
    //MARK: Weak
    weak var model: ACUser?
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        tableView.reloadData()
    }
    
    //MARK: TableView protocols
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        setupBasicsHeaderView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.UI.TableView.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let uiModel = UserSheetTVCellUIModel(model: model!)
        let key = Constants.UI.TableViewCell.userSheetCellKey
        let cell = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath) as! UserSheetTVCell
        cell.configure(with: uiModel)
        cell.tableViewController = self
        return cell
    }
}


//MARK: - Main methods
private extension UserSheetTVController {
    
    //MARK: Private
    func setupTableView() {
        let rowHeight = Constants.UI.TableView.rowHeight
        let sectionHeaderHeight = Constants.UI.TableView.sectionHeaderHeight
        let backgroundView = setupTableBackView()
        tableView.rowHeight = rowHeight
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = sectionHeaderHeight
        tableView.backgroundView = backgroundView
        tableView.allowsSelection = false
    }
    
    func setupTableBackView() -> UIView {
        let gradientSublayer = setupTableBackViewGradientLayer()
        let backgroundBlurView = setupTableBackBlurView()
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.layer.insertSublayer(gradientSublayer, at: 0)
        backgroundView.addSubview(backgroundBlurView)
        return backgroundView
    }
    
    func setupTableBackViewGradientLayer() -> CALayer {
        let locations: [NSNumber] = [0, 0.5]
        let topColor = UIColor.systemGray5.withAlphaComponent(0.25).cgColor
        let bottomColor = UIColor.systemGray6.cgColor
        let gradientLayer = CAGradientLayer()
        let gradientBackgroundColors: [CGColor] = [topColor, bottomColor]
        gradientLayer.frame = view.bounds
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = locations
        return gradientLayer
    }
    
    func setupTableBackBlurView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        let autoresizingMask: UIView.AutoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.autoresizingMask = autoresizingMask
        blurEffectView.frame = view.bounds
        return blurEffectView
    }
    
    func setupBasicsHeaderView() -> UIView {
        let tableViewWidth = self.tableView.frame.width
        let viewFrame = CGRect.init(x: 0, y: 0, width: tableViewWidth, height: 48)
        let headerView = UIView.init(frame: viewFrame)
        let headerLabel = setupBasicsHeaderLabel(with: headerView)
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func setupBasicsHeaderLabel(with headerView: UIView) -> UILabel {
        let content = Constants.UI.Label.headerLabelContent.uppercased()
        let labelFont = UIFont.ACFont(ofSize: 12, weight: .bold)
        let labelWidth = headerView.frame.width - 10
        let labelHeight = headerView.frame.height - 10
        let labelFrame = CGRect.init(x: 8, y: 5, width: labelWidth, height: labelHeight)
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.frame = labelFrame
        label.font = labelFont
        label.text = content
        return label
    }
}

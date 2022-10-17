//
//  UserSheetTableViewCell.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 28.03.2022.
//

import Foundation
import UIKit
import SPAlert

//MARK: - Constants
private extension UserSheetTVCell {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Image {
                
                //MARK: Static
                static let dismissIconName = "multiply"
                static let shareIconName = "square.and.arrow.up"
                static let copyIconName = "rectangle.portrait.on.rectangle.portrait"
            }
        }
    }
}


//MARK: - User sheet TableView Cell
final class UserSheetTVCell: UITableViewCell {
    
    //MARK: Weak
    weak var tableViewController: UITableViewController!
    
    //MARK: Private
    private var presenter: UserSheetPresenterProtocol? {
        return UserSheetPresenter(view: self, content: descriptionTextView.text!)
    }
    
    //MARK: @IBOutlets
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var copyContentButton: ACNeumorphicButton!
    @IBOutlet private weak var shareContentButton: ACNeumorphicButton!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var roleDecorationLabel: UILabel!
    @IBOutlet private weak var newDecorationLabel: UILabel!
    @IBOutlet private weak var leftDecorationLabelWidth: NSLayoutConstraint!
    @IBOutlet private weak var rightDecorationLabelWidth: NSLayoutConstraint!
    
    
    //MARK: @IBActions
    @IBAction func copyContent(_ sender: UIButton) {
        presenter?.onCopyButton()
    }
    
    @IBAction func shareContent(_ sender: UIButton) {
        presenter?.onShareButton()
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        presenter?.onDismissButton()
    }
}


//MARK: - ConfigurableView protocol extension
extension UserSheetTVCell: ACBaseUserSheetCellProtocol, ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with data: UserSheetTVCellUIModelProtocol) {
        setupDateLabel(with: data)
        setupTitleLabel(with: data)
        setupDescriptionTextView(with: data)
        newDecorationLabel.setupDecorationRoleLabel(content: data.extraInfoDescription, tintColor: data.newDecoLabelTintColor)
        roleDecorationLabel.setupDecorationRoleLabel(content: data.roleName)
        dismissButton.setupDarkBarButton(imageSystemName: Constants.UI.Image.dismissIconName)
        copyContentButton.setupCostomBarButton(imageSystemName: Constants.UI.Image.shareIconName)
        shareContentButton.setupCostomBarButton(imageSystemName: Constants.UI.Image.copyIconName)
        rightDecorationLabelWidth.constant = data.rightDecorationLabelWidth
        leftDecorationLabelWidth.constant = data.leftDecorationLabelWidth
        
        ///Setup Cell base properties
        backgroundColor = .clear
    }
    
    internal func moveToThePreviousViewController() {
        tableViewController.dismiss(animated: true, completion: nil)
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        ACActivityManager.presentVC(activityItems: activityItems,
                                    applicationActivities: nil,
                                    on: tableViewController)
    }
}


//MARK: - Main methods
private extension UserSheetTVCell {

    //MARK: Private
    func setupDateLabel(with data: UserSheetTVCellUIModelProtocol) {
        let textColor: UIColor = .tertiaryLabel.withAlphaComponent(0.4)
        let content = data.dateDescription
        let font = UIFont.ACFont(style: .footer)
        dateLabel.numberOfLines = 1
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = textColor
        dateLabel.text = content
        dateLabel.font = font
    }
    
    func setupTitleLabel(with data: UserSheetTVCellUIModelProtocol) {
        let content = data.title
        let font = UIFont.ACFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .label
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupDescriptionTextView(with data: UserSheetTVCellUIModelProtocol) {
        let textColor: UIColor = .label.withAlphaComponent(0.55)
        let content = data.content
        let font = UIFont.ACFont(style: .articleContent)
        descriptionTextView.tintColor = .systemIndigo
        descriptionTextView.textColor = textColor
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.isSelectable = true
        descriptionTextView.isEditable = false
        descriptionTextView.text = content
        descriptionTextView.font = font
    }
}

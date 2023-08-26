//
//  UserSheetTableViewCell.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 28.03.2022.
//

import Foundation
import UIKit

//MARK: - Constants
private extension UserSheetCell {
    
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


//MARK: - Main Cell
final class UserSheetCell: UITableViewCell {
    
    //MARK: Weak
    weak var tableViewController: UITableViewController!
    
    //MARK: Private
    private var uiModel: UserSheetCellUIModelProtocol?
    private var presenter: UserSheetCellPresenterProtocol? {
        return UserSheetCellPresenter(view: self, content: descriptionTextView.text!)
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
extension UserSheetCell: ACBaseUserSheetCellProtocol, ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with data: UserSheetCellUIModelProtocol) {
        uiModel = data
        setupDateLabel()
        setupTitleLabel()
        setupDescriptionTextView()
        dismissButton.setupDarkBarButton(imageSystemName: Constants.UI.Image.dismissIconName)
        copyContentButton.setupCostomBarButton(imageSystemName: Constants.UI.Image.shareIconName)
        shareContentButton.setupCostomBarButton(imageSystemName: Constants.UI.Image.copyIconName)
        newDecorationLabel.setupDecorationRoleLabel(content: uiModel!.extraInfoDescription, tintColor: uiModel!.newDecoLabelTintColor)
        roleDecorationLabel.setupDecorationRoleLabel(content: uiModel!.roleName)
        rightDecorationLabelWidth.constant = uiModel!.rightDecorationLabelWidth
        leftDecorationLabelWidth.constant = uiModel!.leftDecorationLabelWidth
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
private extension UserSheetCell {

    //MARK: Private
    func setupDateLabel() {
        let textColor: UIColor = .tertiaryLabel.withAlphaComponent(0.4)
        let content = uiModel?.dateDescription
        let font = UIFont.ACFont(style: .footer)
        dateLabel.numberOfLines = 1
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = textColor
        dateLabel.text = content
        dateLabel.font = font
    }
    
    func setupTitleLabel() {
        let content = uiModel?.title
        let font = UIFont.ACFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .label
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupDescriptionTextView() {
        let textColor: UIColor = .label.withAlphaComponent(0.55)
        let content = uiModel?.content
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

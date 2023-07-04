//
//  PersonCollectionCell.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.03.2022.
//

import Foundation
import UIKit

//MARK: - Constants
private extension PersonCollectionViewCell {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Label {
                
                //MARK: Static
                static let decorationTeam = "Our Team"
            }
        }
    }
}


//MARK: - Team section Cell
final class PersonCollectionViewCell: ACNeumorphicCollectionViewCell {
    
    //MARK: Private
    private var uiModel: PersonCellUIModelProtocol?
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var decorationImageView: UIImageView!
    @IBOutlet weak var decorationBackImageView: UIImageView!
    @IBOutlet weak var decorationTeamLabel: UILabel!
}


//MARK: - ConfigurableView protocol extension
extension PersonCollectionViewCell: ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with data: PersonCellUIModelProtocol) {
        uiModel = data
        setupPersonTitleLabel()
        setupPersonSubtitleLabel()
        setupPersonDescriptionTextView()
        setupPersonDecorationImageView()
        setupPersonDecorationTeamLabel()
        setupPersonDecorationBackImageView()
        setupBasicsCell(shadowAvailable: uiModel?.isShadowAvailable,
                        backColor: uiModel?.backgroundColor,
                        secondatyColor: uiModel?.secondaryColor,
                        gradientType: .upwards)
    }
}


//MARK: - Main methods
private extension PersonCollectionViewCell {

    //MARK: Private
    func setupPersonTitleLabel() {
        let font = UIFont.ACFont(style: .cellTitle)
        let content = uiModel?.title
        let textColor = uiModel?.tintColor
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        titleLabel.textColor = textColor
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupPersonSubtitleLabel() {
        let font = UIFont.ACFont(style: .cellDeco)
        let backColor = uiModel?.subtitleLabelBackColor
        let textColor = uiModel?.tintColor
        let content = uiModel?.role
        subtitleLabel.layer.masksToBounds = true
        subtitleLabel.layer.cornerRadius = 6
        subtitleLabel.numberOfLines = 0
        subtitleLabel.backgroundColor = backColor
        subtitleLabel.textColor = textColor
        subtitleLabel.text = content
        subtitleLabel.font = font
    }
    
    func setupPersonDescriptionTextView() {
        let font = UIFont.ACFont(style: .cellContent)
        let content = uiModel?.previewDescription
        let textColor = uiModel?.tintColor
        descriptionTextView.isSelectable = false
        descriptionTextView.isEditable = false
        descriptionTextView.textColor = textColor
        descriptionTextView.text = content
        descriptionTextView.font = font
    }
    
    func setupPersonDecorationImageView() {
        let tintColor = uiModel?.decorationImageViewTintColor
        let roleIconImage = uiModel?.decorationIconImage
        let cornerRadius = decorationImageView.frame.height / 4.2
        decorationImageView.layer.cornerRadius = cornerRadius
        decorationImageView.contentMode = .scaleAspectFit
        decorationImageView.tintColor = tintColor
        decorationImageView.image = roleIconImage
    }
    
    func setupPersonDecorationBackImageView() {
        let tintColor = uiModel?.tintColor
        let image = uiModel?.decorationBackImage
        decorationBackImageView.backgroundColor = .clear
        decorationBackImageView.tintColor = tintColor
        decorationBackImageView.image = image
        decorationBackImageView.alpha = 0.085
    }
    
    func setupPersonDecorationTeamLabel() {
        let textColor = uiModel?.tintColor
        let backColor = uiModel?.subtitleLabelBackColor
        let cornerRadius = (decorationTeamLabel.frame.height / 2) - 2
        let content = Constants.UI.Label.decorationTeam.uppercased()
        let font = UIFont.ACFont(ofSize: 9, weight: .regular)
        decorationTeamLabel.layer.cornerRadius = cornerRadius
        decorationTeamLabel.layer.masksToBounds = true
        decorationTeamLabel.backgroundColor = backColor
        decorationTeamLabel.textColor = textColor
        decorationTeamLabel.alpha = 0.55
        decorationTeamLabel.text = content
        decorationTeamLabel.font = font
    }
}

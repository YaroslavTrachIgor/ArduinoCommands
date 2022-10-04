//
//  PersonCollectionCell.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.03.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension PersonCollectionViewCell {
    
    //MARK: Keys
    enum Keys {
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
        setupPersonTitleLabel(with: data)
        setupPersonSubtitleLabel(with: data)
        setupPersonDescriptionTextView(with: data)
        setupPersonDecorationImageView(with: data)
        setupPersonDecorationTeamLabel(with: data)
        setupPersonDecorationBackImageView(with: data)
        setupBasicsCell(shadowAvailable: data.isShadowAvailable,
                        backColor: data.backgroundColor,
                        secondatyColor: data.secondaryColor,
                        gradientType: .upwards)
    }
}


//MARK: - Main methods
private extension PersonCollectionViewCell {

    //MARK: Private
    func setupPersonTitleLabel(with data: PersonCellUIModelProtocol) {
        let font = UIFont.ACFont(style: .cellTitle)
        let content = data.title
        let textColor = data.tintColor
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        titleLabel.textColor = textColor
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupPersonSubtitleLabel(with data: PersonCellUIModelProtocol) {
        let font = UIFont.ACFont(style: .cellDeco)
        let backColor = data.subtitleLabelBackColor
        let textColor = data.tintColor
        let content = data.role
        subtitleLabel.layer.masksToBounds = true
        subtitleLabel.layer.cornerRadius = 6
        subtitleLabel.numberOfLines = 0
        subtitleLabel.backgroundColor = backColor
        subtitleLabel.textColor = textColor
        subtitleLabel.text = content
        subtitleLabel.font = font
    }
    
    func setupPersonDescriptionTextView(with data: PersonCellUIModelProtocol) {
        let font = UIFont.ACFont(style: .cellContent)
        let content = data.previewDescription
        let textColor = data.tintColor
        descriptionTextView.isSelectable = false
        descriptionTextView.isEditable = false
        descriptionTextView.textColor = textColor
        descriptionTextView.text = content
        descriptionTextView.font = font
    }
    
    func setupPersonDecorationImageView(with data: PersonCellUIModelProtocol) {
        let tintColor = data.decorationImageViewTintColor
        let roleIconImage = data.decorationIconImage
        let cornerRadius = decorationImageView.frame.height / 4.2
        decorationImageView.layer.cornerRadius = cornerRadius
        decorationImageView.contentMode = .scaleAspectFit
        decorationImageView.tintColor = tintColor
        decorationImageView.image = roleIconImage
    }
    
    func setupPersonDecorationBackImageView(with data: PersonCellUIModelProtocol) {
        let tintColor = data.tintColor
        let image = data.decorationBackImage
        decorationBackImageView.backgroundColor = .clear
        decorationBackImageView.tintColor = tintColor
        decorationBackImageView.image = image
        decorationBackImageView.alpha = 0.085
    }
    
    func setupPersonDecorationTeamLabel(with data: PersonCellUIModelProtocol) {
        let textColor = data.tintColor
        let backColor = data.subtitleLabelBackColor
        let cornerRadius = (decorationTeamLabel.frame.height / 2) - 2
        let content = Keys.UI.Label.decorationTeam.uppercased()
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

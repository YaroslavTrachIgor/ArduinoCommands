//
//  PersonCollectionCell.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.03.2022.
//

import Foundation
import UIKit

//MARK: - Team section Cell
final class PersonCollectionViewCell: ACNeumorphicCollectionViewCell {
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var decorationImageView: UIImageView!
    @IBOutlet weak var decorationBackImageView: UIImageView!
}


//MARK: - ConfigurableView protocol extension
extension PersonCollectionViewCell: ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with data: PersonCellUIModelProtocol) {
        setupPersonTitleLabel(with: data)
        setupPersonSubtitleLabel(with: data)
        setupPersonDescriptionTextView(with: data)
        setupPersonDecorationImageView(with: data)
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
}

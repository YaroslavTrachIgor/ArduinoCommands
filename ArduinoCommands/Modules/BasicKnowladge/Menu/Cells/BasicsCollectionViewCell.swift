//
//  BasicKnowladgeCollectionCell.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.03.2022.
//

import Foundation
import UIKit

//MARK: - Constants
private extension BasicsCollectionViewCell {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Button {
                
                //MARK: Static
                static let continueTitle = "Continue"
                static let continueSubtitle = "3 Weeks Free"
            }
        }
    }
}


//MARK: - Basics section Cell
final class BasicsCollectionViewCell: ACNeumorphicCollectionViewCell {
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleTextView: UITextView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var decorationImageView: UIImageView!
}


//MARK: - ConfigurableView protocol extension
extension BasicsCollectionViewCell: ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with data: BasicsCellUIModelProtocol) {
        continueButton.configuration = setupContinueButtonConfiguration(with: data)
        setupBasicsSubtitleLabel(with: data)
        setupBasicsTitleLabel(with: data)
        setupDecorationImageView(with: data)
        setupBasicsCell(shadowAvailable: data.isShadowAvailable,
                        backColor: data.backgroundColor,
                        secondatyColor: data.secondaryColor,
                        gradientType: .upwards)
    }
}


//MARK: - Main methods
private extension BasicsCollectionViewCell {

    //MARK: Private
    func setupBasicsTitleLabel(with data: BasicsCellUIModelProtocol) {
        let font = UIFont.ACFont(style: .cellTitle)
        let content = data.title
        let textColor = data.tintColor
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 2
        titleLabel.textColor = textColor
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupBasicsSubtitleLabel(with data: BasicsCellUIModelProtocol) {
        let font = UIFont.ACFont(style: .cellContent)
        let content = data.previewDescription
        let textColor = data.tintColor
        subtitleTextView.backgroundColor = .clear
        subtitleTextView.textColor = textColor
        subtitleTextView.text = content
        subtitleTextView.font = font
    }
    
    func setupDecorationImageView(with data: BasicsCellUIModelProtocol) {
        let image = data.decorationImage
        decorationImageView.alpha = 0.65
        decorationImageView.image = image
        decorationImageView.contentMode = .scaleAspectFit
    }
    
    func setupContinueButtonConfiguration(with data: BasicsCellUIModelProtocol) -> UIButton.Configuration {
        var config: UIButton.Configuration = .borderedTinted()
        let attributedTitle = setupContinueButtonAttributedTitle(with: data)
        let attributedSubitle = setupContinueButtonAttributedSubtitle(with: data)
        let baseBackgroundColor = data.tintColor
        config.baseBackgroundColor = baseBackgroundColor
        config.attributedSubtitle = attributedSubitle
        config.attributedTitle = attributedTitle
        config.cornerStyle = .large
        return config
    }
    
    func setupContinueButtonAttributedTitle(with data: BasicsCellUIModelProtocol) -> AttributedString {
        let title = Constants.UI.Button.continueTitle
        let textColor = data.tintColor
        let font = UIFont.ACFont(ofSize: 12.7, weight: .bold)
        var attTitle = AttributedString.init(title)
        attTitle.foregroundColor = textColor
        attTitle.obliqueness = 0
        attTitle.font = font
        return attTitle
    }
    
    func setupContinueButtonAttributedSubtitle(with data: BasicsCellUIModelProtocol) -> AttributedString {
        let title = Constants.UI.Button.continueSubtitle
        let textColor = data.tintColor
        let font = UIFont.ACFont(ofSize: 11.1)
        var attSubtitle = AttributedString.init(title)
        attSubtitle.foregroundColor = textColor
        attSubtitle.strokeColor = textColor
        attSubtitle.obliqueness = 0.015
        attSubtitle.font = font
        return attSubtitle
    }
}

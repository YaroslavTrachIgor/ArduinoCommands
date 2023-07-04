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
                static let continueSubtitle = "to Learn More..."
            }
        }
    }
}


//MARK: - Basics section Cell
final class BasicsCollectionViewCell: ACNeumorphicCollectionViewCell {
    
    //MARK: Private
    private var uiModel: BasicsCellUIModelProtocol?
    
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
        uiModel = data
        continueButton.configuration = setupContinueButtonConfiguration()
        setupBasicsSubtitleLabel()
        setupBasicsTitleLabel()
        setupDecorationImageView()
        setupBasicsCell(shadowAvailable: uiModel?.isShadowAvailable,
                        backColor: uiModel?.backgroundColor,
                        secondatyColor: uiModel?.secondaryColor,
                        gradientType: .upwards)
    }
}


//MARK: - Main methods
private extension BasicsCollectionViewCell {

    //MARK: Private
    func setupBasicsTitleLabel() {
        let font = UIFont.ACFont(style: .cellTitle)
        let content = uiModel?.title
        let textColor = uiModel?.tintColor
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 2
        titleLabel.textColor = textColor
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupBasicsSubtitleLabel() {
        let font = UIFont.ACFont(style: .cellContent)
        let content = uiModel?.previewDescription
        let textColor = uiModel?.tintColor
        subtitleTextView.backgroundColor = .clear
        subtitleTextView.textColor = textColor
        subtitleTextView.text = content
        subtitleTextView.font = font
    }
    
    func setupDecorationImageView() {
        let image = uiModel?.decorationImage
        decorationImageView.alpha = 0.65
        decorationImageView.image = image
        decorationImageView.contentMode = .scaleAspectFit
    }
    
    func setupContinueButtonConfiguration() -> UIButton.Configuration {
        var config: UIButton.Configuration = .borderedTinted()
        let attributedTitle = setupContinueButtonAttributedTitle()
        let attributedSubitle = setupContinueButtonAttributedSubtitle()
        let baseBackgroundColor = uiModel?.tintColor
        config.baseBackgroundColor = baseBackgroundColor
        config.attributedSubtitle = attributedSubitle
        config.attributedTitle = attributedTitle
        config.cornerStyle = .large
        return config
    }
    
    func setupContinueButtonAttributedTitle() -> AttributedString {
        let title = Constants.UI.Button.continueTitle
        let textColor = uiModel?.tintColor
        let font = UIFont.ACFont(ofSize: 12.7, weight: .bold)
        var attTitle = AttributedString.init(title)
        attTitle.foregroundColor = textColor
        attTitle.obliqueness = 0
        attTitle.font = font
        return attTitle
    }
    
    func setupContinueButtonAttributedSubtitle() -> AttributedString {
        let title = Constants.UI.Button.continueSubtitle
        let textColor = uiModel?.tintColor
        let font = UIFont.ACFont(ofSize: 11.1)
        var attSubtitle = AttributedString.init(title)
        attSubtitle.foregroundColor = textColor
        attSubtitle.strokeColor = textColor
        attSubtitle.obliqueness = 0.015
        attSubtitle.font = font
        return attSubtitle
    }
}

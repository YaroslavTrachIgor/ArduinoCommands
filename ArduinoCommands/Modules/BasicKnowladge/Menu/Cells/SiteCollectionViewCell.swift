//
//  SiteCollectionViewCell.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 18.03.2022.
//

import Foundation
import UIKit

//MARK: - Sites section Cell
final class SiteCollectionViewCell: ACNeumorphicCollectionViewCell {
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var siteLinkLabel: UILabel!
    @IBOutlet weak var decorationImageView: UIImageView!
    @IBOutlet weak var decorationBackImageView: UIImageView!
}


//MARK: - ConfigurableView protocol extension
extension SiteCollectionViewCell: ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with data: SiteCellUIModelProtocol) {
        setupSiteLinkLabel(with: data)
        setupSiteLinkDecorationImage(with: data)
        setupSiteTitleLabel(with: data)
        setupSiteSubtitleLabel(with: data)
        setupSiteDecorationBackImageView(with: data)
        setupBasicsCell(shadowAvailable: data.isShadowAvailable,
                        backColor: data.backgroundColor,
                        secondatyColor: data.secondaryBackColor,
                        gradientType: .diagonal)
    }
}


//MARK: - Main methods
private extension SiteCollectionViewCell {

    //MARK: Private
    func setupSiteTitleLabel(with data: SiteCellUIModelProtocol) {
        let content = data.title
        let textColor = data.tintColor
        titleLabel.textColor = textColor
        titleLabel.text = content
    }
    
    func setupSiteSubtitleLabel(with data: SiteCellUIModelProtocol) {
        let content = data.subtitle
        let textColor = data.tintColor
        subtitleLabel.numberOfLines = 0
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.textColor = textColor
        subtitleLabel.text = content
    }
    
    func setupSiteLinkLabel(with data: SiteCellUIModelProtocol) {
        let font = UIFont.ACFont(style: .cellDeco)
        let content = data.siteLinkTitle
        let backColor = data.secondaryTintColor
        let textColor = data.siteLinkTextColor
        let cornerRadius = (siteLinkLabel.frame.height / 2) - 3
        siteLinkLabel.layer.masksToBounds = true
        siteLinkLabel.layer.cornerRadius = cornerRadius
        siteLinkLabel.backgroundColor = backColor
        siteLinkLabel.textColor = textColor
        siteLinkLabel.text = content
        siteLinkLabel.font = font
    }
    
    func setupSiteLinkDecorationImage(with data: SiteCellUIModelProtocol) {
        let cornerRadius = decorationImageView.frame.height / 2
        let tintColor = data.secondaryTintColor
        let image = data.decorationImage
        decorationImageView.layer.cornerRadius = cornerRadius
        decorationImageView.contentMode = .scaleAspectFit
        decorationImageView.tintColor = tintColor
        decorationImageView.image = image
    }
    
    func setupSiteDecorationBackImageView(with data: SiteCellUIModelProtocol) {
        let image = data.decorationBackImage
        decorationBackImageView.alpha = 0.3
        decorationBackImageView.image = image
        decorationBackImageView.contentMode = .scaleToFill
        decorationBackImageView.backgroundColor = .clear
    }
}

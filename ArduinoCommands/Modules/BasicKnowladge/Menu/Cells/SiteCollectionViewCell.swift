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
    
    //MARK: Private
    private var uiModel: SiteCellUIModelProtocol?
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var linkIconImageView: UIImageView!
    @IBOutlet weak var linkIconImageBackView: UIView!
}


//MARK: - ConfigurableView protocol extension
extension SiteCollectionViewCell: ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with data: SiteCellUIModelProtocol) {
        uiModel = data
        
        layer.masksToBounds = false
        layer.cornerRadius = CGFloat.Corners.baseACBigRounding + 2
        
        backgroundColor = .systemBackground
        
        linkIconImageBackView.backgroundColor = UIColor(hexString: "#034394")
        linkIconImageBackView.layer.cornerRadius = 14
        linkIconImageBackView.layer.shadowColor = linkIconImageBackView.backgroundColor?.cgColor
        linkIconImageBackView.layer.shadowOpacity = 0.7
        linkIconImageBackView.layer.shadowRadius = 6
        linkIconImageBackView.layer.shadowOffset = CGSize(width: 2, height: 5)
        
//        setupSiteLinkLabel()
//        setupSiteLinkDecorationImage()
//        setupSiteTitleLabel()
//        setupSiteSubtitleLabel()
//        setupSiteDecorationBackImageView()
//        setupBasicsCell(shadowAvailable: uiModel?.isShadowAvailable,
//                        backColor: uiModel?.backgroundColor,
//                        secondatyColor: uiModel?.secondaryBackColor,
//                        gradientType: .diagonal)
    }
}
//
//
////MARK: - Main methods
//private extension SiteCollectionViewCell {
//
//    //MARK: Private
//    func setupSiteTitleLabel() {
//        let content = uiModel?.title
//        let textColor = uiModel?.tintColor
//        titleLabel.textColor = textColor
//        titleLabel.text = content
//    }
//
//    func setupSiteSubtitleLabel() {
//        let content = uiModel?.subtitle
//        let textColor = uiModel?.tintColor
//        subtitleLabel.numberOfLines = 0
//        subtitleLabel.backgroundColor = .clear
//        subtitleLabel.textColor = textColor
//        subtitleLabel.text = content
//    }
//
//    func setupSiteLinkLabel() {
//        let font = UIFont.ACFont(style: .cellDeco)
//        let content = uiModel?.siteLinkTitle
//        let backColor = uiModel?.secondaryTintColor
//        let textColor = uiModel?.siteLinkTextColor
//        let cornerRadius = (siteLinkLabel.frame.height / 2) - 3
//        siteLinkLabel.layer.masksToBounds = true
//        siteLinkLabel.layer.cornerRadius = cornerRadius
//        siteLinkLabel.backgroundColor = backColor
//        siteLinkLabel.textColor = textColor
//        siteLinkLabel.text = content
//        siteLinkLabel.font = font
//    }
//
//    func setupSiteLinkDecorationImage() {
//        let cornerRadius = decorationImageView.frame.height / 2
//        let tintColor = uiModel?.secondaryTintColor
//        let image = uiModel?.decorationImage
//        decorationImageView.layer.cornerRadius = cornerRadius
//        decorationImageView.contentMode = .scaleAspectFit
//        decorationImageView.tintColor = tintColor
//        decorationImageView.image = image
//    }
//
//    func setupSiteDecorationBackImageView() {
//        let image = uiModel?.decorationBackImage
//        decorationBackImageView.alpha = 0.3
//        decorationBackImageView.image = image
//        decorationBackImageView.contentMode = .scaleToFill
//        decorationBackImageView.backgroundColor = .clear
//    }
//}

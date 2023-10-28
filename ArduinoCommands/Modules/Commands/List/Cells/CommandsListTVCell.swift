//
//  CommandTableViewCell.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.05.2022.
//

import Foundation
import UIKit

//MARK: - Command preview Cell
final class CommandsListTVCell: UITableViewCell {
    
    //MARK: Private
    private var uiModel: CommandUIModel?
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var contentBackView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var decorationImageView: UIImageView!
    @IBOutlet weak var decorationImageBackView: UIView!
    @IBOutlet weak var rightDecorationLabel: UILabel!
    @IBOutlet weak var leftDecorationLabel: UILabel!
    @IBOutlet weak var middleDecorationLabel: UILabel!
    @IBOutlet weak var middleLabelWidth: NSLayoutConstraint!
}


//MARK: - ConfigurableView protocol extension
extension CommandsListTVCell: ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with data: CommandUIModel) {
        uiModel = data
        setupCommandCellTitleLabel()
        setupCommandCellSubtitleLabel()
        setupCommandCellContentTextView()
        setupMethodDecoLabel()
        setupDevicesDecoLabel()
        setupReturnsDecoLabel()
        setupDecorationImageView()
        setupDecorationImageBackView()
        setupContentBackView()
        backgroundColor = .clear
    }
}


//MARK: - Main methods
private extension CommandsListTVCell {
    
    //MARK: Private
    func setupCommandCellTitleLabel() {
        let content = uiModel?.title
        let font = UIFont.ACFont(style: .articleTitle)
        subtitleLabel.numberOfLines = 1
        titleLabel.textColor = .label
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupCommandCellSubtitleLabel() {
        let content = uiModel?.subtitle
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textColor = .label
        subtitleLabel.text = content
    }
    
    func setupDecorationImageView() {
        let image = uiModel?.icon
        decorationImageView.contentMode = .scaleAspectFit
        decorationImageView.tintColor = .white
        decorationImageView.image = image
    }
    
    func setupDecorationImageBackView() {
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding + 2
        let shadowColor = UIColor.appTintColor.withAlphaComponent(0.35).cgColor
        let shadowOffset = CGSize(width: 2, height: 9)
        decorationImageBackView.backgroundColor = .appTintColor
        decorationImageBackView.layer.cornerRadius = cornerRadius
        decorationImageBackView.layer.shadowColor = shadowColor
        decorationImageBackView.layer.shadowOffset = shadowOffset
        decorationImageBackView.layer.shadowOpacity = 0.7
        decorationImageBackView.layer.shadowRadius = 6
    }
    
    func setupCommandCellContentTextView() {
        let textColor: UIColor = .secondaryLabel.withAlphaComponent(0.6)
        let content = uiModel?.previewContent
        let font = UIFont.ACFont(style: .articlePreview)
        contentTextView.isUserInteractionEnabled = false
        contentTextView.backgroundColor = .clear
        contentTextView.isSelectable = false
        contentTextView.isEditable = false
        contentTextView.textColor = textColor
        contentTextView.text = content
        contentTextView.font = font
    }
    
    func setupContentBackView() {
        let backgroundColor = UIColor.secondarySystemGroupedBackground.withAlphaComponent(0.65)
        let cornerRadius = CGFloat.Corners.baseACBigRounding + 3
        contentBackView.backgroundColor = backgroundColor
        contentBackView.layer.cornerRadius = cornerRadius
    }
    
    func setupReturnsDecoLabel() {
        rightDecorationLabel.setupReturnsDecoLabel(with: uiModel!.returnsLabelIsHidden, scaleType: .small)
    }
    
    func setupDevicesDecoLabel() {
        middleDecorationLabel.setupDevicesDecoLabel(with: uiModel?.isDevicesLabelEnabled, scaleType: .small)
        middleLabelWidth.constant = uiModel!.middleLabelWidth
        
        if uiModel!.isInitialMethod {
            middleDecorationLabel.setupInitialDecoLabel(with: uiModel?.isDevicesLabelEnabled, scaleType: .small)
        }
    }
    
    func setupMethodDecoLabel() {
        leftDecorationLabel.setupMethodDecoLabel(scaleType: .small)

        if uiModel!.isLibraryMethodLabelFirst {
            leftDecorationLabel.setupLibraryDecoLabel(scaleType: .small)
        }
    }
}

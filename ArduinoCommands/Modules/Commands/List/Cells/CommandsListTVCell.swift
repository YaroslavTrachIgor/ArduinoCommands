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
//        setupCommandCellSubtitleLabel()
//        setupCommandCellContentTextView()
        rightDecorationLabel.setupReturnsDecoLabel(with: uiModel!.returnsLabelIsHidden, scaleType: .small)
        setupDevicesDecorationLabel()
        setupMethodDecoLabel()
        
        setupCommandCellContentTextView()
        
        backgroundColor = .clear
        
        subtitleLabel.text = uiModel?.subtitle
        
        decorationImageView.tintColor = .white
        decorationImageView.image = uiModel?.icon
        
        decorationImageBackView.backgroundColor = .appTintColor
        decorationImageBackView.layer.cornerRadius = CGFloat.Corners.baseACSecondaryRounding + 2
        decorationImageBackView.layer.shadowColor = decorationImageBackView.backgroundColor?.withAlphaComponent(0.35).cgColor
        decorationImageBackView.layer.shadowOpacity = 0.7
        decorationImageBackView.layer.shadowRadius = 6
        decorationImageBackView.layer.shadowOffset = CGSize(width: 2, height: 9)
        
        contentBackView.backgroundColor = UIColor.secondarySystemGroupedBackground.withAlphaComponent(0.65)
        contentBackView.layer.cornerRadius = CGFloat.Corners.baseACBigRounding + 3
//        let shadowColor = UIColor.systemGray4.withAlphaComponent(0.3).cgColor
//        let shadowOffset = CGSize(width: 2, height: 7)
//        contentBackView.layer.shadowColor = shadowColor
//        contentBackView.layer.shadowOffset = shadowOffset
//        contentBackView.layer.shadowOpacity = 0.6
//        contentBackView.layer.shadowRadius = 6
    }
}


//MARK: - Main methods
private extension CommandsListTVCell {
    
    //MARK: Private
    func setupCommandCellTitleLabel() {
        let content = uiModel?.title
        let font = UIFont.ACFont(style: .articleTitle)
        titleLabel.textColor = .label
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupCommandCellSubtitleLabel() {
        let textColor: UIColor = .label.withAlphaComponent(0.95)
        let content = uiModel?.subtitle
        let font = UIFont.ACFont(style: .articleSubtitle)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textColor = textColor
        subtitleLabel.text = content
        subtitleLabel.font = font
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
    
    func setupDevicesDecorationLabel() {
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

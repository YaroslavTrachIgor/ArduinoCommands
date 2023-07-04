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
    @IBOutlet weak var contentTextView: UITextView!
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
        rightDecorationLabel.setupReturnsDecoLabel(with: uiModel!.returnsLabelIsHidden)
        setupDevicesDecorationLabel()
        setupMethodDecoLabel()
        backgroundColor = UIColor.ACTable.cellBackgroundColor
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
        let textColor: UIColor = .label.withAlphaComponent(0.65)
        let content = uiModel?.previewContent
        let font = UIFont.ACFont(style: .articlePreview)
        contentTextView.isSelectable = false
        contentTextView.isEditable = false
        contentTextView.textColor = textColor
        contentTextView.text = content
        contentTextView.font = font
    }
    
    func setupDevicesDecorationLabel() {
        middleDecorationLabel.setupDevicesDecoLabel(with: uiModel?.isDevicesLabelEnabled)
        middleLabelWidth.constant = uiModel!.middleLabelWidth
        
        if uiModel!.isInitialMethod {
            middleDecorationLabel.setupInitialDecoLabel(with: uiModel?.isDevicesLabelEnabled)
        }
    }
    
    func setupMethodDecoLabel() {
        leftDecorationLabel.setupMethodDecoLabel()
        
        if uiModel!.isLibraryMethodLabelFirst {
            leftDecorationLabel.setupLibraryDecoLabel()
        }
    }
}

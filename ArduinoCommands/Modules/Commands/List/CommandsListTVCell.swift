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
    internal func configure(with data: CommandsListTVCellUIModelProtocol) {
        setupCommandCellTitleLabel(with: data)
        setupCommandCellSubtitleLabel(with: data)
        setupCommandCellContentTextView(with: data)
        rightDecorationLabel.setupReturnsDecoLabel(with: data.returns)
        setupDevicesDecorationLabel(with: data)
        setupMethodDecoLabel(with: data)
        backgroundColor = UIColor.ACTable.cellBackgroundColor
    }
}


//MARK: - Main methods
private extension CommandsListTVCell {
    
    //MARK: Private
    func setupCommandCellTitleLabel(with data: CommandsListTVCellUIModelProtocol) {
        let content = data.title
        let font = UIFont.ACFont(style: .articleTitle)
        titleLabel.textColor = .label
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupCommandCellSubtitleLabel(with data: CommandsListTVCellUIModelProtocol) {
        let textColor: UIColor = .label.withAlphaComponent(0.95)
        let content = data.subtitle
        let font = UIFont.ACFont(style: .articleSubtitle)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textColor = textColor
        subtitleLabel.text = content
        subtitleLabel.font = font
    }
    
    func setupCommandCellContentTextView(with data: CommandsListTVCellUIModelProtocol) {
        let textColor: UIColor = .label.withAlphaComponent(0.65)
        let content = data.previewContent
        let font = UIFont.ACFont(style: .articlePreview)
        contentTextView.isSelectable = false
        contentTextView.isEditable = false
        contentTextView.textColor = textColor
        contentTextView.text = content
        contentTextView.font = font
    }
    
    func setupDevicesDecorationLabel(with data: CommandsListTVCellUIModelProtocol) {
        let isUsedWithDevices = data.isUsedWithDevices
        if data.isFirstSection {
            middleDecorationLabel.setupInitialDecoLabel(with: isUsedWithDevices)
            middleLabelWidth.constant = 74
        } else {
            middleDecorationLabel.setupDevicesDecoLabel(with: isUsedWithDevices)
            middleLabelWidth.constant = 82
        }
    }
    
    func setupMethodDecoLabel(with data: CommandsListTVCellUIModelProtocol) {
        if data.isLibraryMethod {
            leftDecorationLabel.setupLibraryDecoLabel()
        } else {
            leftDecorationLabel.setupMethodDecoLabel()
        }
    }
}

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
    @IBOutlet weak var bookmarkIconImageView: UIImageView!
    
    //MARK: @IBOutlet Collections
    @IBOutlet var decorationImageViews: [UIImageView]!
}


//MARK: - ConfigurableView protocol extension
extension BasicsCollectionViewCell: ACBaseConfigurableView {

    //MARK: Internal
    internal func configure(with data: BasicsCellUIModelProtocol) {
        uiModel = data
        setupTitleLabel()
        setupSubtitleTextView()
        setupBookmarkImageView()
        setupDecorationImageViews()
        setupCellAppearance()
    }
}


//MARK: - Main methods
private extension BasicsCollectionViewCell {
    
    func setupTitleLabel() {
        let content = uiModel?.title
        titleLabel.text = content
        titleLabel.numberOfLines = 2
        titleLabel.setLineSpacing(6)
    }
    
    func setupSubtitleTextView() {
        let textColor = UIColor.white.withAlphaComponent(0.90)
        let content = uiModel?.previewDescription
        subtitleTextView.isUserInteractionEnabled = false
        subtitleTextView.isSelectable = false
        subtitleTextView.textColor = textColor
        subtitleTextView.text = content
    }
    
    func setupBookmarkImageView() {
        bookmarkIconImageView.contentMode = .scaleAspectFit
        bookmarkIconImageView.tintColor = .white
        bookmarkIconImageView.alpha = 0.95
    }
    
    func setupDecorationImageViews() {
        for imageView in decorationImageViews {
            imageView.tintColor = uiModel?.secondaryColor
            imageView.contentMode = .scaleAspectFit
            imageView.alpha = 0.85
        }
    }
    
    func setupCellAppearance() {
        let backgroundColor = uiModel?.backgroundColor
        let cornerRadius = CGFloat.Corners.baseACBigRounding + 10
        let shadowColor = uiModel?.backgroundColor.cgColor
        let shadowOffset = CGSize(width: 2, height: 4)
        self.backgroundColor = backgroundColor
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 10.5
    }
}

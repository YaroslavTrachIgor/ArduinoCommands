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
        
        titleLabel.text = uiModel?.title
        titleLabel.setLineSpacing(6)
        
        subtitleTextView.text = uiModel?.previewDescription
        
        layer.masksToBounds = false
        layer.cornerRadius = CGFloat.Corners.baseACBigRounding + 10
        backgroundColor = uiModel?.backgroundColor
        let shadowColor = uiModel?.backgroundColor.cgColor
        let shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 10.5
        
        for imageView in decorationImageViews {
            imageView.tintColor = uiModel?.secondaryColor
        }
        
        bookmarkIconImageView.tintColor = .white
    }
}

extension UILabel {
    func setLineSpacing(_ lineSpacing: CGFloat) {
        guard let labelText = self.text else {
            return
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString = NSAttributedString(
            string: labelText,
            attributes: [.paragraphStyle: paragraphStyle]
        )
        
        self.attributedText = attributedString
    }
}

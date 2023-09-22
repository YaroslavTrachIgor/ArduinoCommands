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
        
        titleLabel.text = uiModel?.title
        subtitleLabel.text = uiModel?.subtitle
        
        layer.masksToBounds = false
        layer.cornerRadius = CGFloat.Corners.baseACBigRounding + 2
        
        backgroundColor = .secondarySystemGroupedBackground
        
        linkIconImageBackView.backgroundColor = .appTintColor
        linkIconImageBackView.layer.cornerRadius = CGFloat.Corners.baseACSecondaryRounding + 2
        linkIconImageBackView.layer.shadowColor = linkIconImageBackView.backgroundColor?.withAlphaComponent(0.35).cgColor
        linkIconImageBackView.layer.shadowOpacity = 0.7
        linkIconImageBackView.layer.shadowRadius = 6
        linkIconImageBackView.layer.shadowOffset = CGSize(width: 2, height: 9)
        
    }
}

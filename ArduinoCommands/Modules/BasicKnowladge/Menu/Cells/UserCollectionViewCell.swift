//
//  UserCollectionView.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 18.03.2022.
//

import Foundation
import UIKit

//MARK: - Users section Cell
final class UserCollectionViewCell: UICollectionViewCell {
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconImageBackgroundView: UIView!
}


//MARK: - ConfigurableView protocol extension
extension UserCollectionViewCell: ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with data: UserCellUIModelProtocol) {
        setupUsersTitleLabel(with: data)
        setupUsersIconImageView(with: data)
        setupUsersIconImageBackgroundView(with: data)
    }
}


//MARK: - Main methods
private extension UserCollectionViewCell {

    //MARK: Private
    func setupUsersTitleLabel(with data: UserCellUIModelProtocol) {
        let cornerRadius = (titleLabel.frame.height / 2) - 1
        let content = data.title
        let usersTintColor = data.tintColor
        let backgroundColor = data.titleBackgroundColor
        let font = UIFont.ACFont(ofSize: 11, weight: .bold)
        titleLabel.backgroundColor = backgroundColor
        titleLabel.layer.cornerRadius = cornerRadius
        titleLabel.layer.masksToBounds = true
        titleLabel.textAlignment = .center
        titleLabel.textColor = usersTintColor
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupUsersIconImageView(with data: UserCellUIModelProtocol) {
        let userIconImage = data.userIconImage
        let cornerRadius = iconImageView.frame.height / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = cornerRadius
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.image = userIconImage
    }
    
    func setupUsersIconImageBackgroundView(with data: UserCellUIModelProtocol) {
        let size: CGFloat = 4
        let distance: CGFloat = 2
        let rect = CGRect(
            x: -size,
            y: iconImageBackgroundView.frame.height - (size * 0.4) + distance,
            width: iconImageBackgroundView.frame.width + size * 0.6,
            height: size
        )
        let iconCornerRadius = iconImageBackgroundView.frame.height / 2
        let shadowColor = data.userIconImageBackViewTintColor
        let shadowPath = UIBezierPath(ovalIn: rect).cgPath
        iconImageBackgroundView.backgroundColor = .clear
        iconImageBackgroundView.layer.shadowOpacity = 0.5
        iconImageBackgroundView.layer.shadowRadius = 3.4
        iconImageBackgroundView.layer.cornerRadius = iconCornerRadius
        iconImageBackgroundView.layer.shadowColor = shadowColor
        iconImageBackgroundView.layer.shadowPath = shadowPath
    }
}

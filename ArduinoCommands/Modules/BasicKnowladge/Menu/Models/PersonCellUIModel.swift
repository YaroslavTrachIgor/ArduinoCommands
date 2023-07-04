//
//  PersonCellViewModel.swift
//  ArduinoCommands
//
//  Created by User on 08.08.2022.
//

import Foundation
import UIKit

//MARK: - Cell ViewModel protocol
protocol PersonCellUIModelProtocol {
    var title: String! { get }
    var role: String! { get }
    var previewDescription: String! { get }
    var isShadowAvailable: Bool! { get }
    var backgroundColor: UIColor! { get }
    var tintColor: UIColor! { get }
    var secondaryColor: UIColor! { get }
    var decorationImageViewTintColor: UIColor! { get }
    var decorationBackImage: UIImage! { get }
    var decorationIconImage: UIImage! { get }
    var subtitleLabelBackColor: UIColor! { get }
}


//MARK: - Constants
private extension PersonCellUIModel {
    
    //MARK: Private
    enum Constants {
        enum Color {
            
            //MARK: Static
            static let decorationTintColorName = "DecorationTintColor"
            static let decorationSecondaryTintColorName = "DecorationSecondaryTintColor"
            
            static let subtitleBackColorName = "SubtitleBackColor"
            static let subtitleSecondaryColorName = "SubtitleBackSecondaryColor"
        }
    }
}


//MARK: - Cell ViewModel
public struct PersonCellUIModel {
    
    //MARK: Public
    var model: ACPersonCellModel?
}


//MARK: - Cell ViewModel protocol extension
extension PersonCellUIModel: PersonCellUIModelProtocol {
    
    //MARK: Public
    internal var title: String! {
        model?.person.name!
    }
    internal var role: String! {
        model?.person.role!
    }
    internal var previewDescription: String! {
        model?.person.description!
    }
    internal var isShadowAvailable: Bool! {
        model?.shadowAvailable!
    }
    internal var backgroundColor: UIColor! {
        model?.backColor!
    }
    internal var tintColor: UIColor! {
        model?.tintColor!
    }
    internal var secondaryColor: UIColor! {
        model?.secondaryColor!
    }
    internal var decorationImageViewTintColor: UIColor! {
        if isShadowAvailable {
            let mainColorName = Constants.Color.decorationTintColorName
            let mainColor = UIColor(named: mainColorName)
            return mainColor
        } else {
            let secondaryColorName = Constants.Color.decorationSecondaryTintColorName
            let secondaryColor = UIColor(named: secondaryColorName)
            return secondaryColor
        }
    }
    internal var subtitleLabelBackColor: UIColor! {
        if isShadowAvailable {
            let mainColorName = Constants.Color.subtitleBackColorName
            let mainColor = UIColor(named: mainColorName)
            return mainColor
        } else {
            let secondaryColorName = Constants.Color.subtitleSecondaryColorName
            let secondaryColor = UIColor(named: secondaryColorName)
            return secondaryColor
        }
    }
    internal var decorationIconImage: UIImage! {
        let roleIconImageConfig = UIImage.SymbolConfiguration(weight: .medium)
        let roleIconImageName = model?.roleIcon
        let roleIconImage = UIImage(systemName: roleIconImageName!, withConfiguration: roleIconImageConfig)
        return roleIconImage!
    }
    internal var decorationBackImage: UIImage! {
        let decorationBackImageName = model?.backImageName!
        let decorationBackImage = UIImage(named: decorationBackImageName!)
        return decorationBackImage
    }
}

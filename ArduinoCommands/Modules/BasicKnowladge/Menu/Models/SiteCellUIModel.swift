//
//  SiteCellViewModel.swift
//  ArduinoCommands
//
//  Created by User on 08.08.2022.
//

import Foundation
import UIKit

//MARK: - Cell ViewModel protocol
protocol SiteCellUIModelProtocol {
    var title: String! { get }
    var subtitle: String! { get }
    var siteLinkTitle: String! { get }
    var isShadowAvailable: Bool! { get }
    var siteLinkTextColor: UIColor! { get }
    var decorationImage: UIImage! { get }
    var decorationBackImage: UIImage! { get }
    var backgroundColor: UIColor! { get }
    var tintColor: UIColor! { get }
    var secondaryBackColor: UIColor! { get }
    var secondaryTintColor: UIColor! { get }
}


//MARK: - Constants
private extension SiteCellUIModel {
    
    //MARK: Private
    enum Constants {
        enum Label {
            
            //MARK: Static
            static let siteLinkTitle = "Site Link"
        }
        enum Image {
            
            //MARK: Static
            static let decorationImageName = "link.circle.fill"
        }
        enum Color {
            
            //MARK: Static
            static let filledLabelBackColorName = "SiteFilledLabelBackColor"
            static let secondaryLabelBackColorName = "SiteLinkLabelBackColor"
        }
    }
}


//MARK: - Cell ViewModel
public struct SiteCellUIModel {
    
    //MARK: Public
    var model: ACLinkCellModel?
}


//MARK: - Cell ViewModel protocol extension
extension SiteCellUIModel: SiteCellUIModelProtocol {
    
    //MARK: Public
    internal var title: String! {
        model?.content.name!.capitalizeFirstLetter()
    }
    internal var subtitle: String! {
        model?.content.link!
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
    internal var secondaryBackColor: UIColor! {
        model?.secondaryColor!
    }
    internal var siteLinkTitle: String! {
        Constants.Label.siteLinkTitle
    }
    internal var siteLinkTextColor: UIColor! {
        /**
         In some cases *(for instance, when Site link Cell is filled)* we need to use
         special tint and background colors.

         For using the right values we check Cell type with `shadowAvailable` model property,
         because only filled items have special colorful shadow.
         */
        if isShadowAvailable {
            return model?.backColor!
        } else {
            return model?.tintColor!
        }
    }
    internal var decorationImage: UIImage! {
        let imageName = Constants.Image.decorationImageName
        if isShadowAvailable {
            return UIImage(systemName: imageName)
        } else {
            let hierarchicalColor = model?.tintColor!
            let decorationImageConfig = UIImage.SymbolConfiguration(hierarchicalColor: hierarchicalColor!)
            let decorationImage = UIImage(systemName: imageName, withConfiguration: decorationImageConfig)
            return decorationImage
        }
    }
    internal var secondaryTintColor: UIColor! {
        if isShadowAvailable {
            let filledLabelBackColorName = Constants.Color.filledLabelBackColorName
            let filledLabelBackColor = UIColor(named: filledLabelBackColorName)
            return filledLabelBackColor
        } else {
            let secondaryLabelBackColorName = Constants.Color.secondaryLabelBackColorName
            let secondaryLabelBackColor = UIColor(named: secondaryLabelBackColorName)
            return secondaryLabelBackColor
        }
    }
    internal var decorationBackImage: UIImage! {
        let imageName = model?.decorationBackImageName!
        let image = UIImage(named: imageName!)!
        return image
    }
}

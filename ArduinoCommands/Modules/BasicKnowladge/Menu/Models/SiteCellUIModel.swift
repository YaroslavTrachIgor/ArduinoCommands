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
    var isShadowAvailable: Bool! { get }
    var siteLinkTitle: String! { get }
    var siteLinkTextColor: UIColor! { get }
    var decorationImage: UIImage! { get }
    var decorationBackImage: UIImage! { get }
    var backgroundColor: UIColor! { get }
    var tintColor: UIColor! { get }
    var secondaryBackColor: UIColor! { get }
    var secondaryTintColor: UIColor! { get }
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
        model?.content.name!.uppercased()
    }
    internal var subtitle: String! {
        model?.content.link!
    }
    internal var isShadowAvailable: Bool! {
        model?.shadowAvailable!
    }
    internal var siteLinkTitle: String! {
        "Site Link"
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
    internal var siteLinkTextColor: UIColor! {
        /**
         In some cases(when Site link Cell is filled) we need to use
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
        let image: UIImage!
        let imageName = "link.circle.fill"
        if isShadowAvailable {
            image = UIImage(systemName: imageName)
            return image
        } else {
            let config = UIImage.SymbolConfiguration(hierarchicalColor: tintColor)
            image = UIImage(systemName: imageName, withConfiguration: config)
        }
        return image
    }
    internal var secondaryTintColor: UIColor! {
        /**
         Add Constants///////////////////////////////
         */
        let filledLabelBackColor = #colorLiteral(red: 0.999948442, green: 0.7708298564, blue: 0.4927771688, alpha: 1)
        let secondaryLabelBackColor = UIColor(named: "SiteLinkLabelBackColor")!.withAlphaComponent(0.65)
        if isShadowAvailable {
            return filledLabelBackColor
        } else {
            return secondaryLabelBackColor
        }
    }
    internal var decorationBackImage: UIImage! {
        let imageName = model?.decorationBackImageName!
        let image = UIImage(named: imageName!)!
        return image
    }
}

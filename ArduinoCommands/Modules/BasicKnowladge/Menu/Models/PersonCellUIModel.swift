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
    internal var decorationImageViewTintColor: UIColor! {
        /**
         ADD Constants
         */
        if isShadowAvailable {
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.603795841)
        } else {
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.4)
        }
    }
    internal var subtitleLabelBackColor: UIColor! {
        if isShadowAvailable {
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.3308882555)
        } else {
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.09748937338)
        }
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
}

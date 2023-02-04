//
//  ViewModel.swift
//  ArduinoCommands
//
//  Created by User on 08.08.2022.
//

import Foundation
import UIKit

//MARK: - Cell ViewModel protocol
protocol UserCellUIModelProtocol {
    var title: String! { get }
    var tintColor: UIColor! { get }
    var userIconImage: UIImage! { get }
    var userIconImageBackViewTintColor: CGColor! { get }
    var titleBackgroundColor: UIColor! { get }
}


//MARK: - Constants
private extension UserCellUIModel {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Image {
                
                //MARK: Static
                static let userImageIcon = "person.circle.fill"
            }
            enum Color {
                
                //MARK: Static
                static let titleBackColorAlphaComponent = 0.16
                static let userIconBackColorAlphaComponent = 0.5
            }
        }
    }
}


//MARK: - Cell ViewModel
public struct UserCellUIModel {
    
    //MARK: Public
    var model: ACUserCellModel?
}


//MARK: - Cell ViewModel protocol extension
extension UserCellUIModel: UserCellUIModelProtocol {
    
    //MARK: Public
    internal var title: String! {
        model?.content.name!
    }
    internal var tintColor: UIColor! {
        model?.tintColor!
    }
    internal var titleBackgroundColor: UIColor! {
        let tintColor = model?.tintColor!
        let alphaComponent = Constants.UI.Color.titleBackColorAlphaComponent
        let titleBackgroundColor = tintColor?.withAlphaComponent(alphaComponent)
        return titleBackgroundColor
    }
    internal var userIconImageBackViewTintColor: CGColor! {
        let tintColor = model?.tintColor!
        let alphaComponent = Constants.UI.Color.userIconBackColorAlphaComponent
        let userIconImageBackViewTintColor = tintColor?.withAlphaComponent(alphaComponent) as! CGColor
        return userIconImageBackViewTintColor
    }
    internal var userIconImage: UIImage! {
        /**
         In the code below, we check if the users image icon is empty.
         If it is true, we will make icon equal to person system icon `personCircleIconName`.
         In the another case, we will get `model` icon image.
         */
        if model?.content.iconName != nil {
            let basicImageSystemName = model?.content.iconName!
            let basicImage = UIImage(named: basicImageSystemName!)
            return basicImage
        } else {
            let tintColor = model?.tintColor!
            let basicImageSystemName = Constants.UI.Image.userImageIcon
            let config = UIImage.SymbolConfiguration(hierarchicalColor: tintColor!)
            let basicImage = UIImage(systemName: basicImageSystemName, withConfiguration: config)!
            return basicImage
        }
    }
}

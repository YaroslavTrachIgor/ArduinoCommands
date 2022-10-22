//
//  UserSheetTVCellViewModel.swift
//  ArduinoCommands
//
//  Created by User on 09.08.2022.
//

import Foundation
import UIKit

//MARK: - Cell ViewModel protocol
protocol UserSheetCellUIModelProtocol {
    init(model: ACUser)
    var title: String! { get }
    var content: String! { get }
    var newDecoLabelTintColor: UIColor! { get }
    var roleName: String! { get }
    var extraInfoDescription: String! { get }
    var rightDecorationLabelWidth: CGFloat! { get }
    var leftDecorationLabelWidth: CGFloat! { get }
    var dateDescription: String! { get }
}


//MARK: - Cell ViewModel
public final class UserSheetCellUIModel {
    
    //MARK: Private
    private var model: ACUser?
    
    //MARK: Initialization
    init(model: ACUser) {
        self.model = model
    }
}


//MARK: - Cell ViewModel protocol extension
extension UserSheetCellUIModel: UserSheetCellUIModelProtocol {
    
    //MARK: Internal
    internal var title: String! {
        guard let firstName = model?.name else { return nil }
        guard let lastName = model?.surname else { return nil }
        return "\(firstName) \(lastName)."
    }
    internal var content: String! {
        model?.roleDescription!
    }
    internal var roleName: String! {
        model?.role!
    }
    internal var extraInfoDescription: String! {
        model?.extraInfo!
    }
    internal var leftDecorationLabelWidth: CGFloat! {
        model?.roleLabelWidth!
    }
    internal var rightDecorationLabelWidth: CGFloat! {
        model?.extraInfoLabelWidth!
    }
    internal var newDecoLabelTintColor: UIColor! {
        model?.secondaryColor!
    }
    internal var dateDescription: String! {
        /**
         Add Constants ////////////////////////////////////////
         */
        let date = model?.dateWhenAdded
        let dateDescription = Date.description(for: date)
        let whenAddedDescription = "Added on \(dateDescription)".uppercased()
        return whenAddedDescription
    }
}

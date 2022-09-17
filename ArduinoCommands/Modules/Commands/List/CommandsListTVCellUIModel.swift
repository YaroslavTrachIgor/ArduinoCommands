//
//  CommandsListCellViewModel.swift
//  ArduinoCommands
//
//  Created by User on 09.08.2022.
//

import Foundation
import UIKit

//MARK: - Cell ViewModel protocol
protocol CommandsListTVCellUIModelProtocol {
    var title: String! { get }
    var subtitle: String! { get }
    var previewContent: String! { get }
    var isFirstSection: Bool! { get }
    var isUsedWithDevices: Bool! { get }
    var isLibraryMethod: Bool! { get }
    var returns: Bool! { get }
}


//MARK: - Cell ViewModel
public struct CommandsListTVCellUIModel {
    
    //MARK: Private
    private var model: ACCommand?
    
    //MARK: Initialization
    init(model: ACCommand) {
        self.model = model
    }
}


//MARK: - Cell ViewModel protocol extension
extension CommandsListTVCellUIModel: CommandsListTVCellUIModelProtocol {
    
    //MARK: Internal
    internal var title: String! {
        model?.name.uppercased()
    }
    internal var subtitle: String! {
        model?.subtitle.uppercased()
    }
    internal var isLibraryMethod: Bool! {
        model?.isLibraryMethod
    }
    internal var isUsedWithDevices: Bool! {
        model?.isUsedWithDevices
    }
    internal var returns: Bool! {
        model?.returns
    }
    internal var previewContent: String! {
        /**
         ///////////// ADD Constants
         */
        let description = model?.description!
        let descriptionPreview = description!.prefix(90)
        let previewContent = "\(descriptionPreview)..."
        return previewContent
    }
    internal var isFirstSection: Bool! {
        /**
         ////////////////////////////////// ADD Constants
         */
        let currentSubtitle = model?.subtitle.uppercased()
        let sectionSubtitle = "The Main Operators".uppercased()
        return currentSubtitle == sectionSubtitle
    }
}

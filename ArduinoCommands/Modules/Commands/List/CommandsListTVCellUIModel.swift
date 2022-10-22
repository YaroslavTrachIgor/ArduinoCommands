//
//  CommandsListCellViewModel.swift
//  ArduinoCommands
//
//  Created by User on 09.08.2022.
//

import Foundation
import UIKit

//MARK: - Constants
private extension CommandsListTVCellUIModel {
    
    //MARK: Private
    enum Constants {
        
        //MARK: Static
        /**
         The easiest way to keep track of a section's type is through its header(or subtitle of command).
         Therefore, we create a key for this section, which will be the same as in the JSON data file.
         
         This particular one is used to identify cell's command type
         and what keywords definetely to use on the `CommandsListTVCell`.
         */
        static let firstSectionSubtitle = "The main Operators"
    }
}


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
        let description = model?.description!
        let descriptionPreview = description!.prefix(90)
        let previewContent = "\(descriptionPreview)..."
        return previewContent
    }
    internal var isFirstSection: Bool! {
        /**
         This one below is used to determine
         if the section cell shows preview of `Initial` method.
         That is, if the section title is `The Main Operators` than this is the first section
         and we need to use Initial keyword. In the other cases,
         we don't need to add any special identification keywords to the command preview cell.
         All this logic is described in `setupDevicesDecorationLabel(...)` in the Commands List Cell file.
         */
        let currentSubtitle = model?.subtitle.uppercased()
        let sectionSubtitle = Constants.firstSectionSubtitle.uppercased()
        return currentSubtitle == sectionSubtitle
    }
}

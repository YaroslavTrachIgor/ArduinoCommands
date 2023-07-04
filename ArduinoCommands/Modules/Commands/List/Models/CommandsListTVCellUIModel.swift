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
    var isInitialMethod: Bool! { get }
    var isUsedWithDevices: Bool! { get }
    var isLibraryMethod: Bool! { get }
    var middleLabelWidth: CGFloat! { get }
    var returns: Bool! { get }
}


//MARK: - Constants
private extension CommandsListTVCellUIModel {
    
    //MARK: Private
    enum Constants {
        
        //MARK: Static
        static let maxNumOfPreviewContentCharacters: Int = 90
        static let anySectionMiddleLabelWidth: CGFloat = 82
        static let initialMiddleLabelWidth: CGFloat = 74
    }
}


//MARK: - Cell ViewModel
public struct CommandsListTVCellUIModel {
    
    //MARK: Private
    private var model: CommandUIModel?
    
    //MARK: Initialization
    init(model: CommandUIModel) {
        self.model = model
    }
}


//MARK: - Cell ViewModel protocol extension
extension CommandsListTVCellUIModel: CommandsListTVCellUIModelProtocol {
    
    //MARK: Internal
    internal var title: String! {
        model?.title.uppercased()
    }
    internal var subtitle: String! {
        model?.subtitle.uppercased()
    }
    internal var isLibraryMethod: Bool! {
        model?.isLibraryMethodLabelFirst
    }
    internal var isUsedWithDevices: Bool! {
        model?.isDevicesLabelEnabled
    }
    internal var returns: Bool! {
        model?.returnsLabelIsHidden
    }
    internal var previewContent: String! {
        let maxCharacters = Constants.maxNumOfPreviewContentCharacters
        let description = model?.content!
        let descriptionPreview = description!.prefix(maxCharacters)
        let previewContent = "\(descriptionPreview)..."
        return previewContent
    }
    internal var middleLabelWidth: CGFloat! {
        /**
         In the code below, we check the section number using the already initialized variable `isFirstSection`.
         This will help us identify if cell is a part of section, where `Initial` type of cells are contained,
         and then set the width value which will be appropriate for special keywords.
         */
        if isInitialMethod {
            return Constants.initialMiddleLabelWidth
        } else {
            return Constants.anySectionMiddleLabelWidth
        }
    }
    internal var isInitialMethod: Bool! {
        /**
         This one below is used to determine, if the cell of a particular section
         shows preview of the`Initial` method.
         
         That is, if the section title is `The Main Operators` than this is the first section
         and we need to use Initial keyword. In the other cases,
         we don't need to add any special identification keywords to the command preview cell.
         Apart from that, all this logic is described in `setupDevicesDecorationLabel(...)`method  in the Commands List Cell file.
         */
        let currentSubtitle = model?.subtitle.uppercased()
        let sectionSubtitle = ACCommandsSection.Keys.firstSectionSubtitle.uppercased()
        return currentSubtitle == sectionSubtitle
    }
}

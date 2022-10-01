//
//  CommandDetailViewModel.swift
//  ArduinoCommands
//
//  Created by User on 09.08.2022.
//

import Foundation
import UIKit

//MARK: - Cell ViewModel protocol
protocol CommandDetailUIModelProtocol {
    var title: String! { get }
    var subtitle: String! { get }
    var content: String! { get }
    var returns: Bool! { get }
    var isUsedWithDevices: Bool! { get }
    var codeScreenImage: UIImage! { get }
    var syntaxDescription: String! { get }
    var returnsDescription: String! { get }
    var argumentsDescription: String! { get }
}


//MARK: - Cell ViewModel
public final class CommandDetailUIModel {
    var model: ACCommand?
    
    //MARK: Initialization
    init(model: ACCommand) {
        self.model = model
    }
}


//MARK: - Cell ViewModel protocol extension
extension CommandDetailUIModel: CommandDetailUIModelProtocol {
    
    //MARK: Internal
    internal var title: String! {
        model?.name.uppercased()
    }
    internal var subtitle: String! {
        model?.subtitle.uppercased()
    }
    internal var content: String! {
        model?.description
    }
    internal var isUsedWithDevices: Bool! {
        model?.isUsedWithDevices
    }
    internal var returns: Bool! {
        model?.returns
    }
    internal var syntaxDescription: String! {
        model?.details.syntax
    }
    internal var returnsDescription: String! {
        model?.details.returns
    }
    internal var argumentsDescription: String! {
        model?.details.arguments
    }
    internal var codeScreenImage: UIImage! {
        let imageName = model?.imageURL!
        let image = UIImage(named: imageName!)
        return image
    }
}

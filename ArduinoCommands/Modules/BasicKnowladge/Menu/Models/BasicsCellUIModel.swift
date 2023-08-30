//
//  BasicsCellViewModel.swift
//  ArduinoCommands
//
//  Created by User on 08.08.2022.
//

import Foundation
import UIKit

//MARK: - Cell ViewModel protocol
protocol BasicsCellUIModelProtocol {
    var title: String! { get }
    var previewDescription: String! { get }
    var backgroundColor: UIColor! { get }
    var tintColor: UIColor! { get }
    var secondaryColor: UIColor! { get }
    var isShadowAvailable: Bool! { get }
    var decorationImage: UIImage! { get }
}


//MARK: - Cell ViewModel
public struct BasicsCellUIModel {
    
    //MARK: Public
    var model: ACBasicsCellModel?
}


//MARK: - Cell ViewModel protocol extension
extension BasicsCellUIModel: BasicsCellUIModelProtocol {
    
    //MARK: Internal
    internal var title: String! {
        model?.content.title!
    }
    internal var previewDescription: String! {
        model?.content.preview!
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
    internal var isShadowAvailable: Bool! {
        model?.shadowAvailable!
    }
    internal var decorationImage: UIImage! {
        let imageName = model?.decorationImageName!
        return UIImage(named: imageName!)!
    }
}

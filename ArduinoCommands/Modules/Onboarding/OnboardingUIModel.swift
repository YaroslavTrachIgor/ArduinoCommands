//
//  OnboardingUIModel.swift
//  ArduinoCommands
//
//  Created by User on 30.08.2022.
//

import Foundation
import UIKit

//MARK: - ViewModel protocol
protocol OnboardingUIModelProtocol {
    init(model: ACOnboardingHelper)
    var header: String! { get }
    var foreword: String! { get }
    func sectionTitle(for index: Int) -> String!
    func sectionSubtitle(for index: Int) -> String!
    func sectionImage(for index: Int) -> UIImage!
}


//MARK: - Main ViewModel
final class OnboardingUIModel {
    
    //MARK: Private
    private var model: ACOnboardingHelper?
    
    //MARK: Initialization
    init(model: ACOnboardingHelper) {
        self.model = model
    }
}


//MARK: - ViewModel protocol extension
extension OnboardingUIModel: OnboardingUIModelProtocol {
    
    //MARK: Internal
    internal var header: String! {
        return model?.title
    }
    internal var foreword: String! {
        return model?.foreword
    }
    internal func sectionTitle(for index: Int) -> String! {
        return model?.sections[index].title!
    }
    internal func sectionSubtitle(for index: Int) -> String! {
        return model?.sections[index].subtitle!
    }
    internal func sectionImage(for index: Int) -> UIImage! {
        let sectionTintHex = model?.sections[index].tintColorString!
        let imageName = model?.sections[index].imageSystemName!
        let imageTintColor = UIColor(hexString: sectionTintHex!)
        let imageConfig = UIImage.SymbolConfiguration(hierarchicalColor: imageTintColor)
        let image = UIImage(systemName: imageName!, withConfiguration: imageConfig)
        return image
    }
}

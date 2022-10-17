//
//  CommandsDetailPresenter.swift
//  ArduinoCommands
//
//  Created by User on 03.07.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension CommandDetailPresenter {
    
    //MARK: Private
    enum Keys {
        
        //MARK: Static
        static let defaultDetailsTintColor: UIColor = .white
        
        /**
         The sense of advertising system in the app
         is to display ad sessions and ad blocks depending on the type of article.
         Advertising will not be shown if articles are in the first section(`The main Operators`),
         in all other cases ads won't be shown.

         The easiest way to keep track of a section's type is through its header(or subtitle of command).
         Therefore, we create a key for this section, which will be the same as in the JSON data file.
         */
        static let firstSectionSubtitle = "The main Operators"
    }
}


//MARK: - Presenter protocol
internal protocol CommandDetailPresenterProtocol {
    init(view: ACBaseCommandDetailViewControllerProtocol, delegate: CommandDetailViewControllerDelegate, model: ACCommand)
    func onViewDidLoad(completion: @escaping (UIColor) -> Void)
    func onViewDidDisappear()
    func onViewScreenshotButton()
    func onViewCodeSnippet()
    func onPresentDetailsColorPicker()
    func setNewTintColor(with color: UIColor)
    func onChangeContentButton(with index: Int)
    func onCopyDetails(for tag: Int)
    func onHideDetails()
    func onPresentDetails()
    func onShareButton()
    func onBackToMenu()
    func onCopyButton()
}


//MARK: - Main Presenter
final class CommandDetailPresenter {
    
    //MARK: Private
    @ACBaseUserDefaultsColor(key: UserDefaults.Keys.detailsTintColorrKey)
    private var detailsTintColor = Keys.defaultDetailsTintColor
    private weak var delegate: CommandDetailViewControllerDelegate?
    private weak var view: ACBaseCommandDetailViewControllerProtocol?
    private weak var model: ACCommand?
    
    
    //MARK: Initialization
    init(view: ACBaseCommandDetailViewControllerProtocol,
         delegate: CommandDetailViewControllerDelegate,
         model: ACCommand) {
        self.view = view
        self.model = model
        self.delegate = delegate
    }
}


//MARK: - Presenter protocol extension
extension CommandDetailPresenter: CommandDetailPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completion: @escaping (UIColor) -> Void) {
        completion(detailsTintColor)
        view?.setupMainUI()
        view?.setupRateManager()
        view?.presentTabBarWithAnimation(alpha: 0)
        /**
         Before we setup Ad Bunner view,
         we need to check that user wants to read an Article from the `Paid` section.
         
         By using `Command` subtitle we can check:
         if it is first section, than we won't present Ad Bunner,
         in other cases we will distract user with Advertisment.
         */
        if model?.subtitle != Keys.firstSectionSubtitle {
            view?.setupAdBunner()
        }
    }
    
    internal func onViewDidDisappear() {
        view?.presentTabBarWithAnimation(alpha: 1)
    }
    
    internal func onBackToMenu() {
        view?.moveToThePreviousViewController()
    }
    
    internal func onViewScreenshotButton() {
        view?.presentFastImageViewController()
    }
    
    internal func onViewCodeSnippet() {
        view?.presentCodeSnippetViewController()
    }
    
    internal func onShareButton() {
        view?.presentActivityVC(activityItems: [model?.description! as Any])
    }
    
    internal func onHideDetails() {
        view?.presentDetailsViews(with: .hide)
        view?.enableBarViews(with: .present)
    }
    
    internal func onPresentDetails() {
        view?.presentDetailsViews(with: .present)
        view?.enableBarViews(with: .hide)
    }
    
    internal func onPresentDetailsColorPicker() {
        view?.presentColorPickerViewController()
    }
    
    internal func setNewTintColor(with color: UIColor) {
        detailsTintColor = color
        delegate?.setDetailsTintColor(color: color)
        view?.setupMainUI()
    }
    
    internal func onChangeContentButton(with index: Int) {
        switch index {
        case 0:
            view?.changeTextViewContentAnimately(text: (model?.description)!)
        case 1:
            view?.changeTextViewContentAnimately(text: (model?.baseDescription)!)
        default:
            break
        }
    }
    
    internal func onCopyDetails(for tag: Int) {
        let contentForCopying: String!
        switch tag {
        case 0:
            contentForCopying = model?.details.syntax!
        case 1:
            contentForCopying = model?.details.arguments!
        case 2:
            contentForCopying = model?.details.returns!
        default:
            contentForCopying = nil
        }
        ACGrayAlertManager.presentCopiedAlert(contentType: .content)
        ACPasteboardManager.copy(contentForCopying)
    }
    
    internal func onCopyButton() {
        ACGrayAlertManager.presentCopiedAlert(contentType: .article)
        ACPasteboardManager.copy((model?.description!)!)
    }
}

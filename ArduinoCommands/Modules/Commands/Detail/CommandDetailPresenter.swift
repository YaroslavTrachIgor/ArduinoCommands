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
    }
    enum Constants {
        enum ImagesLoadFailAlert {
            
            //MARK: Static
            static let title = "Poor Network Connection"
            static let message = "Failed to load Devices Images because of the Poor Network Connection. Please, check your Wifi network connection or try restarting the app."
        }
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
    func onPresentDeviceImages()
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
        refreshView()
        showAd()
        view?.setupRateManager()
        view?.presentTabBarWithAnimation(alpha: 0)
        
        ACCommandsAnalyticsManager.shared.updateCurrentArticleViews()
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
    
    internal func onPresentDetailsColorPicker() {
        view?.presentColorPickerViewController()
    }
    
    internal func onPresentDeviceImages() {
        view?.presentDeviceImagesCollectionViewController()
    }
    
    internal func onPresentDetails() {
        animateDetails(presentationType: .present)
    }
    
    internal func onHideDetails() {
        animateDetails(presentationType: .hide)
    }
    
    internal func setNewTintColor(with color: UIColor) {
        detailsTintColor = color
        delegate?.setDetailsTintColor(color: color)
        refreshView()
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
        copy(contentForCopying, contentType: .content)
    }
    
    internal func onCopyButton() {
        copy(model?.description!, contentType: .article)
    }
    
    internal func onShareButton() {
        view?.presentActivityVC(activityItems: [model?.shared as Any])
    }
}


//MARK: - Main methods
private extension CommandDetailPresenter {
    
    //MARK: Private
    func refreshView() {
        view?.show(model: CommandDetailFormatter.convert(model!))
        view?.setupMainUI()
        animateDetails(presentationType: .hide)
    }
    
    func showAd() {
        /**
         Before we setup Ad Bunner view, we need to check if the user wants to read
         an article from the paid sections.
         
         By using Command subtitle we can check:
         if it is the first section, than we won't present any Ad screens or bunners,
         in the other cases we will distract user with Advertisments.
         */
        if model?.subtitle != ACCommandsSection.Keys.firstSectionSubtitle {
            view?.setupAdBunner()
        }
    }
    
    func animateDetails(presentationType: ACBasePresentationType) {
        switch presentationType {
        case .present:
            view?.presentDetailsViews(with: .present)
            view?.enableBarViews(with: .hide)
        case .hide:
            view?.presentDetailsViews(with: .hide)
            view?.enableBarViews(with: .present)
        }
    }
    
    func copy(_ content: String!, contentType: ACPasteboardManager.ContentType) {
        ACGrayAlertManager.presentCopiedAlert(contentType: contentType)
        ACPasteboardManager.copy(content)
    }
    
    func presentImagesLoadFailMessage() {
        let title = Constants.ImagesLoadFailAlert.title
        let message = Constants.ImagesLoadFailAlert.message
        ACGrayAlertManager.present(title: title, message: message)
    }
}

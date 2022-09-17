//
//  CommandsDetailPresenter.swift
//  ArduinoCommands
//
//  Created by User on 03.07.2022.
//

import Foundation

//MARK: - Keys
private extension CommandDetailPresenter {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Label {
                
                //MARK: Static
                /**
                 //////////////////
                 */
                static let firstSectionSubtitle = "The main Operators"
            }
        }
    }
}

//MARK: - Presenter protocol
internal protocol CommandDetailPresenterProtocol: ACBasePresenter {
    init(view: ACBaseCommandDetailViewControllerProtocol, model: ACCommand)
    func onViewDidDisappear()
    func onViewScreenshotButton()
    func onViewCodeSnippet()
    func onChangeContentButton(with index: Int)
    func onShareButton()
    func onBackToMenu()
    func onCopyButton()
}


//MARK: - Main Presenter
final class CommandDetailPresenter {
    
    //MARK: Private
    private weak var view: ACBaseCommandDetailViewControllerProtocol?
    private weak var model: ACCommand?
    
    
    //MARK: Initialization
    init(view: ACBaseCommandDetailViewControllerProtocol, model: ACCommand) {
        self.view = view
        self.model = model
    }
}


//MARK: - Presenter protocol extension
extension CommandDetailPresenter: CommandDetailPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad() {
        view?.setupMainUI()
        view?.setupRateManager()
        view?.presentTabBarWithAnimation(alpha: 0)
        /**
         Before we setup Ad Bunner view,
         we need to check that user wants to read an Article from the `Paid` section.
         
         Using `Command` subtitle we can check:
         if it is first section, than we won't present Ad Bunner,
         in other cases we will distract user with Advertisment.
         */
        if model?.subtitle != Keys.UI.Label.firstSectionSubtitle {
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
    
    internal func onCopyButton() {
        ACGrayAlertManager.presentCopiedAlert(contentType: .article)
        ACPasteboardManager.copy((model?.description!)!)
    }
}

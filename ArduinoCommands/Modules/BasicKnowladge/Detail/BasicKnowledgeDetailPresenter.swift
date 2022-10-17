//
//  BasicKnowledgeDetailPresenter.swift
//  ArduinoCommands
//
//  Created by User on 12.07.2022.
//

import Foundation

//MARK: - Presenter protocol
protocol BasicKnowledgeDetailPresenterProtcol: ACBasePresenter {
    init(view: BasicKnowledgeDetailVCProtocol, model: ACBasics)
    func onChangeAppearance()
    func onViewWillDisappear()
    func onCopyContent()
    func onBackToMenu()
    func onGoToWiki()
    func onShare()
}


//MARK: - Main Presenter
final class BasicKnowledgeDetailPresenter {
    
    //MARK: Private
    private weak var view: BasicKnowledgeDetailVCProtocol?
    private weak var model: ACBasics?
    
    
    //MARK: Initionalizate
    init(view: BasicKnowledgeDetailVCProtocol, model: ACBasics) {
        self.model = model
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension BasicKnowledgeDetailPresenter: BasicKnowledgeDetailPresenterProtcol {
    
    //MARK: Internal
    internal func onViewDidLoad() {
        view?.setupMainUI()
        view?.setFastBottomContentViewShadowColor()
        view?.presentTabBarWithAnimation(alpha: 0)
    }
    
    internal func onChangeAppearance() {
        view?.setFastBottomContentViewShadowColor()
    }
    
    internal func onViewWillDisappear() {
        view?.presentTabBarWithAnimation(alpha: 1)
    }
    
    internal func onBackToMenu() {
        view?.moveToThePreviousViewController()
    }
    
    internal func onGoToWiki() {
        let stringURl = model?.stringSiteUrl!
        view?.presentSafariVC(stringURL: stringURl!)
    }
    
    internal func onShare() {
        let activityItems = model?.description!
        view?.presentActivityVC(activityItems: [activityItems!])
    }
    
    internal func onCopyContent() {
        let content = model?.description!
        ACPasteboardManager.copy(content!)
        ACGrayAlertManager.presentCopiedAlert(contentType: .story)
    }
}

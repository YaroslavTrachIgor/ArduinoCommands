//
//  BasicKnowladgePresenter.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.03.2022.
//

import Foundation
import UIKit

//MARK: - Base Completion Handler typealias
typealias ACBasicKnowledgePresenterCompletionHandler = (([BasicKnowledgeSectionRow]) -> Void)


//MARK: - Presenter protocol
internal protocol BasicKnowledgePresenterProtocol {
    init(view: BasicKnowledgeVCProtocol, sections: [BasicKnowledgeSectionRow])
    func onViewDidLoad(completion: @escaping ACBasicKnowledgePresenterCompletionHandler)
    func onDidSelectItemAt(for tag: Int, with row: Int)
    func onPresentSettingsHostVC()
    func onViewDidAppear()
}


//MARK: - Main Presenter
final class BasicKnowledgePresenter {
    
    //MARK: Private
    private var applicationCheckManager: ACApplicationCheckManagerProtocol?
    private var tipService: BasicKnowledgeTipClientProtocol?
    private var sections: [BasicKnowledgeSectionRow]?
    private weak var view: BasicKnowledgeVCProtocol?
    
    
    //MARK: Initionalizate
    init(view: BasicKnowledgeVCProtocol,
         sections: [BasicKnowledgeSectionRow] = BasicKnowledgeContentStorage.prepareSections()) {
        self.applicationCheckManager = ACApplicationCheckManager()
        self.tipService = BasicKnowledgeTipClient()
        self.sections = sections
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension BasicKnowledgePresenter: BasicKnowledgePresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completion: @escaping ACBasicKnowledgePresenterCompletionHandler) {
        view?.setupMainUI()
        noticeNewVersion()
        showOnboarding()
        /**
         In the code below, in order to pass the rows between the entities of the application (Presenter and View),
         we will pass the content of four `Menu` screen sections through a closure.
         */
        completion(sections!)
    }
    
    internal func onViewDidAppear() {
        if let tipAvailable = tipService?.isSettingsTipAvailable, tipAvailable {
            view?.presentSettingsTip()
            tipService?.markSettingsTipAsComplete()
        }
    }
    
    internal func onPresentSettingsHostVC() {
        view?.presentSettingsHostVC()
    }
    
    internal func onDidSelectItemAt(for tag: Int, with row: Int) {
        let section = sections![tag]
        switch section {
        case .links(let sites):
            view?.presentSiteWithSafari(with: sites[row].content)
        case .team(_):
            let user = BasicKnowledgeContentStorage.usersModels[row]
            let userContent = user.content
            /**
             In this section of main Menu, we don't use case constants,
             because it does the same thing, as in `Users` sections.
             
             That's why we get data not from the `.team(...)` case,
             but from the `BasicKnowledgeStorage`entity.
             */
            view?.presentUserSheetVC(with: userContent)
        case .users(let users):
            view?.presentUserSheetVC(with: users[row].content)
        case .basics(let basics):
            view?.presentAdlnterstitial()
            view?.presentDetailVC(with: basics[row].content)
        }
    }
}


//MARK: - Main methods
private extension BasicKnowledgePresenter {
    
    //MARK: Private
    func showOnboarding() {
        applicationCheckManager?.checkIfOnboardingNeeded { isNeededOnboarding in
            if isNeededOnboarding {
                DispatchQueue.main.async {
                    self.view?.presentOnboardingVC()
                }
            }
        }
    }
    
    func noticeNewVersion() {
        applicationCheckManager?.checkVersion { newVersionAvailable in
            if newVersionAvailable {
                ACGrayAlertManager.presentNewVersionAlert()
            }
        }
    }
}

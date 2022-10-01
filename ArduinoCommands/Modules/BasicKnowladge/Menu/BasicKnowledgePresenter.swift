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
    init(view: ACBaseBasicKnowledgeVCProtocol, sections: [BasicKnowledgeSectionRow])
    func onViewDidLoad(completion: @escaping ACBasicKnowledgePresenterCompletionHandler)
    func onDidSelectItemAt(for tag: Int, with row: Int)
    func onPresentSettingsHostVC()
}


//MARK: - Main Presenter
final class BasicKnowledgePresenter {
    
    //MARK: Private
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.isOnboardingNeeded)
    private var isNeededOnboarding = true
    private var sections: [BasicKnowledgeSectionRow]?
    private weak var view: ACBaseBasicKnowledgeVCProtocol?
    
    
    //MARK: Initionalizate
    init(view: ACBaseBasicKnowledgeVCProtocol,
         sections: [BasicKnowledgeSectionRow] = ACBasicKnowledgeStorage.prepareSections()) {
        self.sections = sections
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension BasicKnowledgePresenter: BasicKnowledgePresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completion: @escaping ACBasicKnowledgePresenterCompletionHandler) {
        completion(sections!)
        /**
         In order to pass the rows between the entities of the application(Presenter and View),
         we will pass the content of four `Menu` screen sections through a callback.
         */
        view?.setupMainUI()
        /**
         In the code below, we use special Application characteristics Manager,
         in this case we need it, because we want to check the valid App Version
         and present a Warning Alert if needed.
         */
        ACApplicationCheckManager.shared.checkVersion {
            ACGrayAlertManager.presentNewVersionAlert()
        }
    }
    
    internal func onOnboardingPresent() {
        if isNeededOnboarding {
            view?.presentOnboardingVC()
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
            let user = ACBasicKnowledgeStorage.usersModels[row]
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
            view?.presentDetailVC(with: basics[row].content)
        }
    }
}

//
//  OnboardingPresenter.swift
//  ArduinoCommands
//
//  Created by User on 20.06.2022.
//

import Foundation

//MARK: - Presenter protocol
internal protocol OnboardingPresenterProtocol: ACBasePresenter {
    init(view: ACBaseOnboardingViewController)
}


//MARK: - Main Presenter
final class OnboardingPresenter {
    
    //MARK: Private
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.isOnboardingNeeded)
    private var isNeededOnboarding = true
    private weak var view: ACBaseOnboardingViewController?
    
    
    //MARK: Initialization
    init(view: ACBaseOnboardingViewController) {
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension OnboardingPresenter: OnboardingPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad() {
        let model = ACAPIManager.parseOnboardingJsonContent()
        let uiModel = OnboardingUIModel(model: model)
        isNeededOnboarding = false
        view?.setupContent(with: uiModel)
        view?.setupMainUI()
    }
}

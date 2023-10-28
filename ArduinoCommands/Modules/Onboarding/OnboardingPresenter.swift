//
//  OnboardingPresenter.swift
//  ArduinoCommands
//
//  Created by User on 20.06.2022.
//

import Foundation

//MARK: - Presenter protocol
internal protocol OnboardingPresenterProtocol: ACBasePresenter {
    init(view: OnboardingViewControllerProtocol, service: ACOnboardingAPIClientProtocol)
    func onDismiss()
}


//MARK: - Main Presenter
final class OnboardingPresenter {
    
    //MARK: Private
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.Onboarding.isOnboardingNeeded)
    private var isNeededOnboarding = true
    private var service: ACOnboardingAPIClientProtocol?
    private weak var view: OnboardingViewControllerProtocol?
    
    
    //MARK: Initialization
    init(view: OnboardingViewControllerProtocol,
         service: ACOnboardingAPIClientProtocol = ACOnboardingAPIClient(fileName: ACFilenames.onboardingFile)) {
        self.service = service
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension OnboardingPresenter: OnboardingPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad() {
        let data = service?.parseOnboardingContent()
        guard let model = data else { dismiss(); return }
        let uiModel = OnboardingFormatter.convert(model)
        isNeededOnboarding = false
        view?.setupContent(with: uiModel)
        view?.setupMainUI()
    }
    
    internal func onDismiss() {
        view?.dismissOnboardingVC(completion: nil)
    }
}


//MARK: - Main methods
private extension OnboardingPresenter {
    
    //MARK: Private
    func dismiss() {
        view?.dismissOnboardingVC(completion: { [self] in
            view?.presentOnboardingAPILoadFailedAlert()
        })
    }
}

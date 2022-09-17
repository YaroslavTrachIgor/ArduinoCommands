//
//  UserSheetPresenter.swift
//  ArduinoCommands
//
//  Created by User on 02.07.2022.
//

import Foundation

//MARK: - Presenter protocol
protocol UserSheetPresenterProtocol {
    init(view: ACBaseUserSheetCellProtocol, content: String)
    func onCopyButton()
    func onShareButton()
    func onDismissButton()
}


//MARK: - Main Presenter
final class UserSheetPresenter {
    
    //MARK: Private
    private weak var view: ACBaseUserSheetCellProtocol?
    private var content: String?
    
    
    //MARK: Initionalizate
    init(view: ACBaseUserSheetCellProtocol, content: String) {
        self.content = content
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension UserSheetPresenter: UserSheetPresenterProtocol {
    
    //MARK: Internal
    internal func onDismissButton() {
        view?.moveToThePreviousViewController()
    }
    
    internal func onShareButton() {
        view?.presentActivityVC(activityItems: [content!])
    }
    
    internal func onCopyButton() {
        ACPasteboardManager.copy(content!)
        ACGrayAlertManager.presentCopiedAlert(contentType: .content)
    }
}

//
//  UserSheetListPresenter.swift
//  ArduinoCommands
//
//  Created by User on 21.10.2022.
//

import Foundation

//MARK: - Presenter protocol
protocol UserSheetListPresenterProtocol: ACBasePresenter {
    func onChangeAppearance()
}


//MARK: - Main Presenter
final class UserSheetListPresenter {
    
    //MARK: Private
    private weak var view: UserSheetListControllerProtcol?

    
    //MARK: Initionalizate
    init(view: UserSheetListControllerProtcol) {
        self.view = view
    }
}


//MARK: - Presenter protocol extension
extension UserSheetListPresenter: UserSheetListPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad() {
        view?.setupMainUI()
    }
    
    internal func onChangeAppearance() {
        view?.updateTableViewBackground()
    }
}

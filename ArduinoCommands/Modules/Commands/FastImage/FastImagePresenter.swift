//
//  FastImagePresenter.swift
//  ArduinoCommands
//
//  Created by User on 27.06.2022.
//

import Foundation
import UIKit

//MARK: - Presenter protocol
internal protocol FastImagePresenterProtocol: ACBasePresenter {
    init(view: AFastImageViewControllerProtocol, image: UIImage)
    func onShareButton()
    func onCopyButton()
}


//MARK: - Main Presenter
final class FastImagePresenter {
    
    //MARK: Private
    private weak var view: AFastImageViewControllerProtocol?
    private weak var image: UIImage?
    
    
    //MARK: Initialization
    init(view: AFastImageViewControllerProtocol, image: UIImage) {
        self.view = view
        self.image = image
    }
}


//MARK: - Presenter protocol extension
extension FastImagePresenter: FastImagePresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad() {
        view?.setupMainUI()
    }
    
    internal func onShareButton() {
        view?.presentActivityVC(activityItems: [image!])
    }
    
    internal func onCopyButton() {
        ACGrayAlertManager.presentCopiedAlert(contentType: .screenshot)
        ACPasteboardManager.copy(image!)
    }
}

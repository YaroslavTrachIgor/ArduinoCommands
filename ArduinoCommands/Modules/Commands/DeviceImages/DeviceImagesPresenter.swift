//
//  DeviceImagesPresenter.swift
//  ArduinoCommands
//
//  Created by User on 04.02.2023.
//

import Foundation
import UIKit

//MARK: - Keys
private extension DeviceImagesPresenter {
    
    //MARK: Private
    enum Keys {
        enum ErrorMessage {
            
            //MARK: Static
            static let title = "Error connecting to the Images Database"
            static let message =  "Detailed Error message: "
        }
    }
}

//MARK: - Presenter protocol
protocol DeviceImagesPresenterProtocol {
    func onViewDidLoad(completion: @escaping (([UIImage]) -> ()))
    func onViewSafeAreaInsetsDidChange()
    func onDismiss()
}


//MARK: - Main Presenter
final class DeviceImagesPresenter {
    
    //MARK: Private
    private weak var view: DeviceImagesCollectionViewControllerProtocol?
    private weak var model: ACDevice?
    private var deviceImages = [UIImage]()
    
    
    //MARK: Initionalizate
    init(view: DeviceImagesCollectionViewControllerProtocol?, model: ACDevice?) {
        self.view = view
        self.model = model
    }
}


//MARK: - Presenter protocol extension
extension DeviceImagesPresenter: DeviceImagesPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completion: @escaping (([UIImage]) -> ())) {
        view?.setupMainUI()
        fetchImages(completion: { [self] in
            completion(deviceImages)
        })
    }
    
    internal func onViewSafeAreaInsetsDidChange() {
        view?.setCollectionViewContentInset()
    }
    
    internal func onDismiss() {
        view?.presentPreviousViewController()
    }
}


//MARK: - Main methods
private extension DeviceImagesPresenter {
    
    //MARK: Private
    func fetchImages(completion: @escaping ACBaseCompletionHandler) {
        guard let deviceName = model?.name else { return }
        let stringURL = ACURLs.API.devicesImagesAPIFirstPart + deviceName + ACURLs.API.devicesImagesAPISecondPart
        let url = URL(string: stringURL)
        let helper = APIHelper(url: url)
        helper.get { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let jsonResults = try JSONDecoder().decode(ACDeviceImagesAPIResponse.self, from: data)
                    for jsonResult in jsonResults.results! {
                        guard let stringURL = jsonResult.urls?.regular else { return }
                        guard let url = URL(string: stringURL) else { return }
                        let imageDownloader = ACImageDownloader(url: url)
                        imageDownloader.downloadImage { image in
                            DispatchQueue.main.async {
                                self?.deviceImages.append(image!)
                                self?.view?.reloadCollectionView()
                                completion()
                            }
                        }
                    }
                } catch {
                    self?.showErrorMessage(with: error)
                }
            case .failure(let error):
                self?.showErrorMessage(with: error)
            }
        }
    }
    
    func showErrorMessage(with error: Error) {
        let title = Keys.ErrorMessage.title
        let message = Keys.ErrorMessage.message + error.localizedDescription
        ACGrayAlertManager.present(title: title, message: message)
    }
}

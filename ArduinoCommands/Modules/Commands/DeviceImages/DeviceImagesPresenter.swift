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


//MARK: - Base Comletion Handler
typealias DeviceImagesFetchComletionHandler = (([URL]) -> Void)


//MARK: - Presenter protocol
protocol DeviceImagesPresenterProtocol {
    func onViewDidLoad(completion: @escaping DeviceImagesFetchComletionHandler)
    func onChooseCollectionViewLayout(with index: Int)
    func onViewSafeAreaInsetsDidChange()
    func onExpandGallery(with hasTappedOnExpandGallery: inout Bool)
    func onDidSelect(for row: Int)
    func onDismiss()
}


//MARK: - Main Presenter
final class DeviceImagesPresenter {
    
    //MARK: Private
    private weak var view: DeviceImagesCollectionViewControllerProtocol?
    private weak var model: ACDevice?
    private var deviceImagesURLs = [URL]()
    
    
    //MARK: Initionalizate
    init(view: DeviceImagesCollectionViewControllerProtocol?, model: ACDevice?) {
        self.view = view
        self.model = model
    }
}


//MARK: - Presenter protocol extension
extension DeviceImagesPresenter: DeviceImagesPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completion: @escaping DeviceImagesFetchComletionHandler) {
        view?.setupMainUI()
        fetchImages(completion: { urls in
            completion(urls)
        })
        if !ACNetworkManager.shared.isConnected {
            view?.presentFetchingErrorAlert()
        }
    }
    
    internal func onExpandGallery(with isGalleryExpanded: inout Bool) {
        if isGalleryExpanded {
            changeGalleryFrame(index: 0)
        } else {
            changeGalleryFrame(index: 2)
        }
        isGalleryExpanded.toggle()
    }
    
    internal func onChooseCollectionViewLayout(with index: Int) {
        view?.setNewCollectionViewLayout(with: index)
    }
    
    internal func onViewSafeAreaInsetsDidChange() {
        view?.setCollectionViewContentInset()
    }
    
    internal func onDismiss() {
        view?.presentPreviousViewController()
    }
    
    internal func onDidSelect(for row: Int) {
        fetchImages { urls in
            let url = urls[row]
            let imageDownloader = ACImageDownloader(url: url)
            imageDownloader.downloadImage { [self] image in
                guard let image = image else { return }
                self.view?.presentFullImageViewController(with: image)
            }
        }
    }
}


//MARK: - Main methods
private extension DeviceImagesPresenter {
    
    //MARK: Private
    func fetchImages(completion: @escaping DeviceImagesFetchComletionHandler) {
        guard let deviceName = model?.name else { return }
        let stringURL = ACURLs.API.devicesImagesAPIFirstPart + deviceName + ACURLs.API.devicesImagesAPISecondPart
        let url = URL(string: stringURL)
        let helper = APIHelper(url: url)
        Task {
            do {
                /**
                 In the code below, we create an instance of `APIHelper` object
                 that will help us to fetch all the URLs of images of Arduino Devices.
                 
                 Pay attension to the fact that this method only parses URLs of the pictures,
                 and does not fill CollectionView cells with images.
                 Each ImageView in `DeviceImageCollectionViewCell` will be configured by itself
                 in the `configure` method.
                 */
                let data = try await helper.get()
                let jsonResults = try JSONDecoder().decode(ACDeviceImagesAPIResponse.self, from: data)
                for jsonResult in jsonResults.results! {
                    guard let stringURL = jsonResult.urls?.regular else { return }
                    guard let url = URL(string: stringURL) else { return }
                    self.deviceImagesURLs.append(url)
                }
                /**
                 In the code below, we need to be certain that UI will be updated from the Main Thread.
                 That's why, we use `MainActor` to reload Device Images CollectionView data
                 and to throw the URLs array.
                 */
                await MainActor.run {
                    completion(deviceImagesURLs)
                    view?.reloadCollectionView()
                }
            } catch {
                await showErrorMessage(with: error)
            }
        }
    }
    
    @MainActor func showErrorMessage(with error: Error) {
        let title = Keys.ErrorMessage.title
        let message = Keys.ErrorMessage.message + error.localizedDescription
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   icon: .error,
                                   style: .iOS16AppleMusic)
    }
    
    func changeGalleryFrame(index: Int) {
        view?.setNewCollectionViewLayout(with: index)
        view?.setNewGallerySegmentIndex(index: index)
    }
}

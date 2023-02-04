//
//  DeviceImagesCollectionViewController.swift
//  ArduinoCommands
//
//  Created by User on 25.12.2022.
//

import UIKit

//MARK: - Main ViewController protocol
protocol DeviceImagesCollectionViewControllerProtocol: ACBaseViewController {
    func setCollectionViewContentInset()
    func presentPreviousViewController()
    func reloadCollectionView()
}


//MARK: - Constants
private extension DeviceImagesCollectionViewController {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum CollectionView {
                
                //MARK: Static
                static let baseInset: CGFloat = 0
            }
            enum CollectionViewCell {
                
                //MARK: Static
                static let imageCellId = "DeviceImageCell"
            }
            enum Image {
                
                //MARK: Static
                static let backButtonIcon = "arrow.left"
            }
        }
    }
}


//MARK: - Main ViewController
final class DeviceImagesCollectionViewController: UICollectionViewController {
    
    //MARK: Weak
    weak var device: ACDevice!
    
    //MARK: Private
    var rows = [UIImage]()
    var presenter: DeviceImagesPresenterProtocol? {
        return DeviceImagesPresenter(view: self, model: device)
    }
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.onViewDidLoad(completion: { rows in
            self.rows = rows
        })
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        presenter?.onViewSafeAreaInsetsDidChange()
    }
    
    //MARK: @objc
    @objc func dismiss(sender: UIButton) {
        presenter?.onDismiss()
    }
    
    //MARK: CollectionView protocols
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = rows[indexPath.row]
        let identifier = Constants.UI.CollectionViewCell.imageCellId
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? DeviceImageCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: image)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageVC = FastImageViewController()
        imageVC.image = rows[indexPath.row]
        presentSheet(with: imageVC, detents: [.large()])
    }
}


//MARK: - ViewController protocol extension
extension DeviceImagesCollectionViewController: DeviceImagesCollectionViewControllerProtocol {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupCollectionView()
        setupBackBarButtonItem()
        view.backgroundColor = .secondarySystemGroupedBackground
    }
    
    internal func presentPreviousViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    internal func setCollectionViewContentInset() {
        var viewInsets = view.safeAreaInsets
        let baseInset = Constants.UI.CollectionView.baseInset
        viewInsets.top = baseInset
        viewInsets.bottom = baseInset
        collectionView.contentInset = viewInsets
    }
    
    internal func reloadCollectionView() {
        collectionView.reloadData()
    }
}


//MARK: - Main methods
private extension DeviceImagesCollectionViewController {
    
    //MARK: Private
    func setupCollectionView() {
        let identifier = Constants.UI.CollectionViewCell.imageCellId
        collectionView!.register(DeviceImageCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    func setupBackBarButtonItem() {
        let action = #selector(dismiss)
        let imageName = Constants.UI.Image.backButtonIcon
        let backButtonView = UIView()
        backButtonView.setupFastImageCollectionViewBarView(action: action,
                                                           imageName: imageName,
                                                           title: nil,
                                                           for: self)
        let backBarButton = UIBarButtonItem.init(customView: backButtonView)
        navigationItem.leftBarButtonItem = backBarButton
    }
}

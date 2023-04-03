//
//  DeviceImagesCollectionViewController.swift
//  ArduinoCommands
//
//  Created by User on 25.12.2022.
//

import UIKit

//MARK: - Main ViewController protocol
protocol DeviceImagesCollectionViewControllerProtocol: ACBaseViewController {
    func presentFullImageViewController(with image: UIImage)
    func setNewCollectionViewLayout(with index: Int)
    func setNewGallerySegmentIndex(index: Int)
    func setCollectionViewContentInset()
    func presentPreviousViewController()
    func presentFetchingErrorAlert()
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
            enum Alert {
                
                //MARK: Static
                static let fetchingErrorTitle = "Poor Network Connection"
                static let fetchingErrorMessage = "Images of the Arduino Devices cannot be fetched, since an error occured while trying to connect to the Database."
            }
            enum CollectionViewCell {
                
                //MARK: Static
                static let imageCellId = "DeviceImageCell"
            }
            enum BarButtonItem {
                
                //MARK: Static
                static let barTitle = "Devices"
                static let layoutButton = "crop"
                static let backButtonIcon = "arrow.left"
            }
        }
    }
}


final class DevicesImagesGallerySegmentedControl: UISegmentedControl {
    
    private var segmentInset: CGFloat = 0.1 {
        didSet {
            if segmentInset == 0 {
                segmentInset = 0.1
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.height / 2
        layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        layer.borderWidth = 0.2
        layer.masksToBounds = true
        
        selectedSegmentTintColor = .clear
        
        let selectedImageViewIndex = numberOfSegments
        if let selectedImageView = self.subviews[selectedImageViewIndex] as? UIImageView {
            selectedImageView.image = nil
            selectedImageView.backgroundColor = UIColor(named: "DevicesImagesSelectedSegmentBack")
            selectedImageView.layer.cornerRadius = selectedImageView.frame.height / 2
        }
        
        let defaultButtonTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        setTitleTextAttributes(defaultButtonTextAttributes, for: .normal)
        setTitleTextAttributes(defaultButtonTextAttributes, for: .selected)
    }
}



public extension UICollectionViewFlowLayout {
    
    //MARK: Public
    static func setupBasicGalleryFlowLayout(width: CGFloat, basicSpacing: CGFloat = 1) -> UICollectionViewFlowLayout {
        let itemSize = CGSize(width: width, height: width)
        let layout: UICollectionViewFlowLayout = .init()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = basicSpacing
        layout.minimumLineSpacing = basicSpacing
        layout.itemSize = itemSize
        return layout
    }
}



//MARK: - Main ViewController
final class DeviceImagesCollectionViewController: UICollectionViewController {
    
    //MARK: Weak
    weak var device: ACDevice!
    
    //MARK: Private
    private var rows = [URL]()
    private var isGalleryExpanded: Bool = false
    private var presenter: DeviceImagesPresenterProtocol? {
        return DeviceImagesPresenter(view: self, model: device)
    }
    private lazy var gallerySegmentedControl: UISegmentedControl = {
        let segmentedControl = DevicesImagesGallerySegmentedControl(items: ["1:4", "1:2", "1:1"])
        let action = #selector(chooseCollectionViewLayout(sender: ))
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: action, for: .valueChanged)
        return segmentedControl
    }()
    
    
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
    
    //MARK: CollectionView protocols
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = rows[indexPath.row]
        let identifier = Constants.UI.CollectionViewCell.imageCellId
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? DeviceImageCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: url)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.onDidSelect(for: indexPath.row)
    }
    
    //MARK: @objc
    @objc func expandGallery() {
        presenter?.onExpandGallery(with: &isGalleryExpanded)
    }
    
    @objc func chooseCollectionViewLayout(sender: UISegmentedControl) {
        presenter?.onChooseCollectionViewLayout(with: sender.selectedSegmentIndex)
    }
    
    @objc func dismiss(sender: UIButton) {
        presenter?.onDismiss()
    }
}


//MARK: - ViewController protocol extension
extension DeviceImagesCollectionViewController: DeviceImagesCollectionViewControllerProtocol {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupCollectionView()
        setupToolBar()
        setupNavigationItem()
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
    
    internal func presentFullImageViewController(with image: UIImage) {
        let imageVC = FastImageViewController()
        imageVC.image = image
        presentSheet(with: imageVC, detents: [.large()])
    }
    
    internal func presentFetchingErrorAlert() {
        let title = Constants.UI.Alert.fetchingErrorTitle
        let message = Constants.UI.Alert.fetchingErrorMessage
        ACAlertManager.shared.presentSimple(title: title, message: message, on: self)
    }
    
    internal func setNewCollectionViewLayout(with index: Int) {
        guard let newLayout = getCollectionViewLayout(with: index) else { return }
        collectionView.setCollectionViewLayout(newLayout, animated: true)
    }
    
    internal func setNewGallerySegmentIndex(index: Int) {
        gallerySegmentedControl.selectedSegmentIndex = index
    }
    
    internal func reloadCollectionView() {
        collectionView.reloadData()
    }
}


//MARK: - Main methods
private extension DeviceImagesCollectionViewController {
    
    //MARK: Private
    func setupCollectionView() {
        let collectionViewCellType = DeviceImageCollectionViewCell.self
        let identifier = Constants.UI.CollectionViewCell.imageCellId
        collectionView!.register(collectionViewCellType, forCellWithReuseIdentifier: identifier)
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    func setupNavigationItem() {
        let leftBarButtonItems = [setupBackBarButtonItem()]
        let rightBarButtonItems = [setupBarTitleItem(), UIBarButtonItem.spacer(), setupLayoutButtonItem()]
        navigationItem.leftBarButtonItems = leftBarButtonItems
        navigationItem.rightBarButtonItems = rightBarButtonItems
    }
    
    func setupToolBar() {
        let toolbar = UIToolbar()
        let barHeight: CGFloat = 60
        let maskedCorners: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding + 4
        let spacerBarItem = UIBarButtonItem.spacer()
        let segmentedControlBarItem = UIBarButtonItem(customView: gallerySegmentedControl)
        let toolBarItmes: [UIBarButtonItem] = [spacerBarItem, segmentedControlBarItem, spacerBarItem]
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.layer.maskedCorners = maskedCorners
        toolbar.layer.cornerRadius = cornerRadius
        toolbar.layer.borderColor = borderColor
        toolbar.layer.borderWidth = 0.4
        toolbar.layer.masksToBounds = true
        toolbar.items = toolBarItmes
        view.addSubview(toolbar)
        
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: barHeight)
        ])
    }
    
    func setupBackBarButtonItem() -> UIBarButtonItem {
        let action = #selector(dismiss)
        let imageName = Constants.UI.BarButtonItem.backButtonIcon
        let backButtonView = UIView()
        backButtonView.setupFastImageCollectionViewBarView(action: action,
                                                           imageName: imageName,
                                                           font: nil,
                                                           title: nil,
                                                           for: self)
        let backBarButton = UIBarButtonItem.init(customView: backButtonView)
        return backBarButton
    }
    
    func setupBarTitleItem() -> UIBarButtonItem {
        let barTitleView = UIView()
        let font = UIFont.systemFont(ofSize: 13.5, weight: .semibold)
        let title = Constants.UI.BarButtonItem.barTitle
        barTitleView.setupFastImageCollectionViewBarView(action: nil,
                                                         width: 72,
                                                         imageName: nil,
                                                         font: font,
                                                         title: title,
                                                         for: self)
        let barTitleButton = UIBarButtonItem.init(customView: barTitleView)
        barTitleButton.customView?.isUserInteractionEnabled = false
        return barTitleButton
    }
    
    func setupLayoutButtonItem() -> UIBarButtonItem {
        let action = #selector(expandGallery)
        let font = UIFont.systemFont(ofSize: 13.5, weight: .semibold)
        let layoutButtonView = UIView()
        let imageName = Constants.UI.BarButtonItem.layoutButton
        layoutButtonView.setupFastImageCollectionViewBarView(action: action,
                                                             imageName: imageName,
                                                             font: font,
                                                             title: nil,
                                                             for: self)
        let layoutButton = UIBarButtonItem.init(customView: layoutButtonView)
        return layoutButton
    }
    
    //MARK: Fast methods
    func getCollectionViewLayout(with index: Int) -> UICollectionViewFlowLayout? {
        let viewWidth = view.frame.size.width
        var width: CGFloat?
        switch index {
        case 0:
            width = viewWidth / 4 - 1
        case 1:
            width = viewWidth / 2 - 1
        case 2:
            width = viewWidth
        default:
            break
        }
        return .setupBasicGalleryFlowLayout(width: width!)
    }
}

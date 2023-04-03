//
//  DeviceImageCollectionViewCell.swift
//  ArduinoCommands
//
//  Created by User on 26.12.2022.
//

import Foundation
import UIKit

//MARK: - Constants
private extension DeviceImageCollectionViewCell {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Image {
                
                //MARK: Static
                static let configuredImageAlpha: CGFloat = 9.5
                static let reusableImageAlpha: CGFloat = 0.02
                static let reusableImageName: String = "arduino-icon-28"
            }
        }
    }
}


//MARK: - Main CollectionView Cell
final class DeviceImageCollectionViewCell: UICollectionViewCell {
    
    //MARK: Private
    private var reusableImage: UIImage {
        let imageAlpha = Constants.UI.Image.reusableImageAlpha
        let imageName = Constants.UI.Image.reusableImageName
        let image = UIImage(named: imageName)?.alpha(imageAlpha)
        return image!
    }
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = reusableImage
        return imageView
    }()
    
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError()
    }
    
    //MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setupReusableImageView()
    }
}


//MARK: - ConfigurableView protocol extension
extension DeviceImageCollectionViewCell: ACBaseConfigurableView {
    
    //MARK: Internal
    internal func configure(with url: URL) {
        imageView.downloadImage(with: url)
        setupConfiguredImageView()
    }
}


//MARK: - Main methods
private extension DeviceImageCollectionViewCell {
    
    //MARK: Private
    func setupConfiguredImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = Constants.UI.Image.configuredImageAlpha
    }
    
    func setupReusableImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = reusableImage
    }
}

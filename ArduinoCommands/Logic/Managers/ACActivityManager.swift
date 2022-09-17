//
//  ActivityManager\.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 28.03.2022.
//

import Foundation
import UIKit

//MARK: - Manager for fast ActivityVC presenting
final public class ACActivityManager {
    
    //MARK: Static
    static func presentVC(activityItems: [Any],
                          applicationActivities: [UIActivity]? = nil,
                          tintColor: UIColor = .systemIndigo,
                          on vc: UIViewController) {
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        UIApplication.keyWindow?.tintColor = tintColor
        vc.present(activityVC, animated: true)
    }
}


//MARK: - Application window extension for creating costom keyWindow
public extension UIApplication {
    
    //MARK: Static
    static var keyWindow: UIWindow? {
        /**
         To give a costom tint color for such "Apple" views like `UIActivityViewController`
         we create artificial `kewWindow` value for `UIApplication`.
         We can easily get access to the view(like: tint color) settings by this property.
         */
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}

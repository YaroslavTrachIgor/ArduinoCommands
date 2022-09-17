//
//  BasicKnowladgeModel.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.03.2022.
//

import Foundation
import UIKit

//MARK: - Main model
public final class ACBasics {
    var title: String?
    var decoTitle: String?
    var subtitle: String?
    var description: String?
    var stringSiteUrl: String?
    var preview: String?
    var date: Date?
    
    //MARK: Initialization
    init(title: String?,
         decoTitle: String?,
         subtitle: String?,
         preview: String?,
         stringSiteUrl: String?,
         description: String?,
         date: Date?) {
        self.title = title
        self.decoTitle = decoTitle
        self.subtitle = subtitle
        self.description = description
        self.stringSiteUrl = stringSiteUrl
        self.preview = preview
        self.date = date
    }
}


//MARK: - Cell model
public struct ACBasicsCellModel {
    var content: ACBasics
    var backColor: UIColor?
    var tintColor: UIColor?
    var secondaryColor: UIColor?
    var shadowAvailable: Bool?
    var decorationImageName: String?
}

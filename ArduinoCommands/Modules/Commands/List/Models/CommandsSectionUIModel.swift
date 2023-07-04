//
//  CommandsSectionUIModel.swift
//  ArduinoCommands
//
//  Created by User on 2023-06-30.
//

import Foundation
import UIKit

//MARK: - Commands Section model for UI
struct CommandsSectionUIModel {
    let header: String!
    let footer: String!
    let headerHeight: CGFloat!
    let commands: [CommandUIModel]!
}

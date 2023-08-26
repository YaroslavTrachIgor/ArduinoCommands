//
//  CommandDetailBackgroundView.swift
//  ArduinoCommands
//
//  Created by User on 07.10.2022.
//

import Foundation
import UIKit

//MARK: - Main View
final class CommandDetailBackgroundView: UIView {
    
    //MARK: @IBOutlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var syntaxHeaderLabel: UILabel!
    @IBOutlet weak var syntaxDescriptionLabel: UILabel!
    @IBOutlet weak var syntaxDescriptionBackView: UIView!
    @IBOutlet weak var argumentsHeaderLabel: UILabel!
    @IBOutlet weak var argumentsDescriptionLabel: UILabel!
    @IBOutlet weak var argumentsDescriptionBackView: UIView!
    @IBOutlet weak var returnsHeaderLabel: UILabel!
    @IBOutlet weak var returnsDescriptionLabel: UILabel!
    @IBOutlet weak var returnsDescriptionBackView: UIView!
    @IBOutlet weak var changeTintColorButton: UIButton!
    
    
    //MARK: @IBOutlet Collections
    @IBOutlet var copyButtons: [UIButton]!
}

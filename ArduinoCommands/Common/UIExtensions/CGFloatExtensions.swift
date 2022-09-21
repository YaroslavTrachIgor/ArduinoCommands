//
//  CGFloatExtensions.swift
//  ArduinoCommands
//
//  Created by User on 04.08.2022.
//

import Foundation
import UIKit

//MARK: - Setup basic 64-bit Floating type properties
public extension CGFloat {
    
    //MARK: Public
    enum Corners {
        
        //MARK: Static
        public static var baseACSecondaryRounding: CGFloat {
            return 12.0
        }
        public static var baseACRounding: CGFloat {
            return 20.0
        }
        public static var baseACBigRounding: CGFloat {
            return 28.0
        }
    }
}

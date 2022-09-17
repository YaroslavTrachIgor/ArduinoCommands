//
//  ACGradientTypes.swift
//  ArduinoCommands
//
//  Created by User on 24.07.2022.
//

import Foundation
import UIKit

//MARK: - Gradient Types
public enum ACGradientType {
    case side
    case upwards
    case diagonal
}


//MARK: - Fast gradient points setup
public extension ACGradientType {
    
    //MARK: Public
    func getStartPoint() -> CGPoint {
        switch self {
        case .side:
            return CGPoint(x: 0, y: 1)
        case .upwards:
            return CGPoint(x: 1, y: 1)
        case .diagonal:
            return CGPoint(x: 1, y: 1)
        }
    }
    
    func getEndPoint() -> CGPoint {
        switch self {
        case .side:
            return CGPoint(x: 1, y: 1)
        case .upwards:
            return CGPoint(x: 1, y: 0)
        case .diagonal:
            return CGPoint(x: 0, y: 0)
        }
    }
}

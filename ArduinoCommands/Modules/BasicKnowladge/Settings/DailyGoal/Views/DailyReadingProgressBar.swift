//
//  DailyReadingProgressBar.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-28.
//

import Foundation
import SwiftUI

//MARK: - Constants
private extension DailyReadingProgressBar {
    
    //MARK: Private
    enum Constants {
        enum Colors {
            
            //MARK: Static
            static let red           = Color(hex: "ED4D4D")
            static let orange        = Color(hex: "E59148")
            static let yellow        = Color(hex: "EFBF39")
            static let lightYellow   = Color(hex: "EEED56")
            static let green         = Color(hex: "32E1A0")
        }
        enum ColorLocations {
            
            //MARK: Static
            static let red           = 0.39000002
            static let orange        = 0.48000002
            static let yellow        = 0.59999999
            static let lightYellow   = 0.71999988
            static let green         = 0.80999977
        }
    }
}


//MARK: - Main View
struct DailyReadingProgressBar: View {
    
    //MARK: Public
    var progress: Double
    var lineWidth: Double
    
    //MARK: View Configuration
    var body: some View {
        progressLeftHalfCircle
        progressHalfCircle
    }
}


//MARK: - Main properties
private extension DailyReadingProgressBar {
    
    //MARK: Private
    var progressLeftHalfCircle: some View {
        Circle()
            .trim(from: 0.3, to: 0.9)
            .stroke(style: StrokeStyle(
                lineWidth: lineWidth,
                lineCap: .round,
                lineJoin: .round)
            )
            .foregroundColor(Color(UIColor.systemGray4))
            .rotationEffect(.degrees(54.5))
            .opacity(0.3)
    }
    var progressHalfCircle: some View {
        Circle()
            .trim(from: 0.3, to: 0.3 + CGFloat(self.progress) * 0.6)
            .stroke(style: StrokeStyle(
                lineWidth: lineWidth,
                lineCap: .round,
                lineJoin: .round)
            )
            .fill(AngularGradient(gradient: Gradient(stops: [
                .init(color: Constants.Colors.red,           location: Constants.ColorLocations.red),
                .init(color: Constants.Colors.orange,        location: Constants.ColorLocations.orange),
                .init(color: Constants.Colors.yellow,        location: Constants.ColorLocations.yellow),
                .init(color: Constants.Colors.lightYellow,   location: Constants.ColorLocations.lightYellow),
                .init(color: Constants.Colors.green,         location: Constants.ColorLocations.green)]
            ), center: .center))
            .rotationEffect(.degrees(54.5))
    }
}

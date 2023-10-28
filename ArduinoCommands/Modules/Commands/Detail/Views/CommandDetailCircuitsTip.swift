//
//  CommandDetailCircuitsTip.swift
//  ArduinoCommands
//
//  Created by User on 2023-10-28.
//

import Foundation
import SwiftUI
import TipKit

//MARK: - Constants
@available(iOS 17.0, *)
private extension CommandDetailCircuitsTip {
    
    //MARK: Private
    enum Constants {
        
        //MARK: Static
        static let title = "View Circuits"
        static let message = "Use the Circuits section to discover real use cases for Arduino commands."
        static let imageName = "arduinchikPlaying"
    }
}


//MARK: - Main Tip
@available(iOS 17.0, *)
struct CommandDetailCircuitsTip: Tip {
    let id = UUID()
    
    var title: Text {
        Text(Constants.title)
    }
    
    var message: Text? {
        Text(Constants.message)
    }
    
    var image: Image? {
        Image(Constants.imageName)
    }
}


//MARK: - Tip ViewStyle
@available(iOS 17.0, *)
struct CommandDetailCircuitsTipViewStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90)
                .clipped()
                .padding([.leading, .top, .bottom], 8)
                .padding([.trailing], 0)
            
            VStack(alignment: .leading) {
                configuration.title?
                    .foregroundStyle(Color(.clear))
                    .overlay {
                        LinearGradient(
                            colors: [
                                Color(.label.withAlphaComponent(0.6)),
                                Color(.label.withAlphaComponent(0.25))
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            configuration.title?
                                .font(Font.system(size: 15, weight: .semibold))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        )
                        .padding(.bottom, -18)
                        .padding(.leading, 16)
                        .frame(width: 150)
                    }
                configuration.message?
                    .foregroundStyle(Color(.clear))
                    .multilineTextAlignment(.center)
                    .overlay {
                        LinearGradient(
                            colors: [
                                Color(.label.withAlphaComponent(0.4)),
                                Color(.label.withAlphaComponent(0.15))
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            configuration.message?
                                .font(Font.system(size: 13, weight: .regular))
                                .multilineTextAlignment(.leading)
                        )
                    }
                    .padding(.leading, -10)
            }
        }
    }
}

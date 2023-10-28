//
//  BasicKnowledgeSettingsTip.swift
//  ArduinoCommands
//
//  Created by User on 2023-10-28.
//

import Foundation
import SwiftUI
import TipKit

//MARK: - Constants
@available(iOS 17.0, *)
private extension BasicKnowledgeSettingsTip {
    
    //MARK: Private
    enum Constants {
        
        //MARK: Static
        static let title = "Modify Settings"
        static let message = "Use Settings section to access personal analytics and modify application parameters."
        static let imageName = "arduinchikIcon"
    }
}


//MARK: - Main Tip
@available(iOS 17.0, *)
struct BasicKnowledgeSettingsTip: Tip {
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
struct BasicKnowledgeSettingsTipViewStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .clipped()
                .padding([.leading], 15)
                .padding([.trailing], 8)
            
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
                        )
                        .padding(.bottom, -40)
                        .padding(.leading, 1)
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
            }
        }
    }
}

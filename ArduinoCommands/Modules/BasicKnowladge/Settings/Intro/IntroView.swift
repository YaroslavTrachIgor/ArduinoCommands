//
//  IntroView.swift
//  ArduinoCommands
//
//  Created by User on 13.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct IntroView: View {
    
    //MARK: Private
    @StateObject
    private var viewModel = IntroViewModel()
    @Environment(\.presentationMode)
    private var presentationMode
    
    //MARK: View Configuration
    var body: some View {
        ZStack {
            IntroTabView()
        }
        .background(IntroBackgroundView())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .environmentObject(viewModel)
        .onReceive(viewModel.$viewIsHidden, perform: { isPresenting in
            hideIntro(if: isPresenting)
        })
    }
}


//MARK: - Main methods
private extension IntroView {
    
    //MARK: Private
    func hideIntro(if isPresenting: Bool) {
        if isPresenting {
            presentationMode.wrappedValue.dismiss()
            viewModel.viewIsHidden = false
        }
    }
}

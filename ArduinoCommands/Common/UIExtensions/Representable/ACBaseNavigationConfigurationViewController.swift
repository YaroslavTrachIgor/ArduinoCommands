//
//  ACBaseNavigationConfigurationViewController.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI
import UIKit

//MARK: - Main Configurator Callback
typealias ACBaseNavigationConfiguratorCallback = (UINavigationController) -> Void


//MARK: - Fast NavBar setup for `SwiftUI` View extension
public extension View {
    
    //MARK: Public
    /**
     All the code below is needed for creating a special `View` feature
     that gives us an opportunity to setup `navigationBar` in SwiftUI files quickly.
     
     The main preference of this solution is that
     we don't have to set navigation bar properties for the second time
     after hiding a particular  `View` that uses this modifier.
     */
    func configureNavigationBar(configure: @escaping (UINavigationController) -> Void) -> some View {
        modifier(ACBaseNavigationConfigurationViewModifier(configure: configure))
    }
}


//MARK: - Main NavController configuration ViewModifier
public struct ACBaseNavigationConfigurationViewModifier: ViewModifier {
    
    //MARK: Public
    let configure: ACBaseNavigationConfiguratorCallback

    
    //MARK: Main ViewModifier
    public func body(content: Content) -> some View {
        content.background(ACBaseNavigationConfigurator(configure: configure))
    }
}


//MARK: - Main NavController configurator
public struct ACBaseNavigationConfigurator: UIViewControllerRepresentable {
    
    //MARK: Public
    let configure: ACBaseNavigationConfiguratorCallback

    
    //MARK: Costom navigation ViewController Lifecycle
    public func makeUIViewController(
        context: UIViewControllerRepresentableContext<ACBaseNavigationConfigurator>) -> ACBaseNavigationConfigurationViewController {
        ACBaseNavigationConfigurationViewController(configure: configure)
    }

    public func updateUIViewController(
        _ uiViewController: ACBaseNavigationConfigurationViewController,
        context: UIViewControllerRepresentableContext<ACBaseNavigationConfigurator>
    ) {}
}


//MARK: - Main configurable Navigation ViewController
final public class ACBaseNavigationConfigurationViewController: UIViewController {
    
    //MARK: Private
    private let configure: ACBaseNavigationConfiguratorCallback

    
    //MARK: Initionalizate
    init(configure: @escaping ACBaseNavigationConfiguratorCallback) {
        self.configure = configure
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: Lifecycle
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configure(navigationController!)
    }
}

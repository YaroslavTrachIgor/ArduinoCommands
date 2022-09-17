//
//  BasicKnowledgeDetailViewModel.swift
//  ArduinoCommands
//
//  Created by User on 10.08.2022.
//

import Foundation
import UIKit

//MARK: - Cell ViewModel protocol
protocol BasicKnowledgeDetailUIModelProtocol {
    init(model: ACBasics)
    var title: String! { get }
    var content: String! { get }
    var dateDescription: String! { get }
}


//MARK: - Cell ViewModel
public final class BasicKnowledgeDetailUIModel {
    
    //MARK: Private
    private var model: ACBasics?
    
    //MARK: Initialization
    init(model: ACBasics) {
        self.model = model
    }
}


//MARK: - Cell ViewModel protocol extension
extension BasicKnowledgeDetailUIModel: BasicKnowledgeDetailUIModelProtocol {
    
    //MARK: Internal
    internal var title: String! {
        model?.decoTitle!.uppercased()
    }
    internal var content: String! {
        model?.description!
    }
    internal var dateDescription: String! {
        let date = model?.date
        let dateDescription = Date.description(for: date).uppercased()
        return dateDescription
    }
}

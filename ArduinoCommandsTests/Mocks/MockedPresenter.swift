//
//  MockedPresenter.swift
//  ArduinoCommandsTests
//
//  Created by Yaroslav Trach on 30.05.2022.
//

import Foundation
@testable import ArduinoCommands
//
////MARK: - Mocked example of Presenter
//final class MockedPresenter: CommandsListPresenterProtocol {
//
//    //MARK: Weak
//    weak var view: ACBaseCommandsListTableViewController?
//
//
//    //MARK: Initionalizate
//    init(view: ACBaseCommandsListTableViewController) {
//        self.view = view
//    }
//
//    //MARK: Public
//    func onViewDidLoad(with commandsList: inout [CommandsSection]) {
//        commandsList = [
//            CommandsSection(name: "My Section",
//                            commands: [ACCommand(name: "My Command name",
//                                               subtitle: "My Command subtitle",
//                                               description: "My Command description",
//                                               baseDescription: "My Command basic description",
//                                               imageURL: nil,
//                                               isFunction: false,
//                                               isUsedWithDevices: true)
//                                      ])
//        ]
//        view?.setupMainUI()
//    }
//
//    func onRemindRowAction(currentCommand: ACCommand, for date: Date) {
//        ///Do something...
//    }
//
//    func onShareRowAction(currentCommand: ACCommand) {
//        ///Do something...
//    }
//
//    func onDidSelectRow(with sender: IndexPath) {
//        ///Do something...
//    }
//}

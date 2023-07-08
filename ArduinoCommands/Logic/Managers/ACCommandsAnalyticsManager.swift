//
//  ACCommandsAnalyticsManager.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-07.
//

import Foundation

//MARK: - Manager for Command Views analytics
final public class ACCommandsAnalyticsManager {
    
    //MARK: Static
    static let shared = ACCommandsAnalyticsManager()
    
    //MARK: Initialization
    private init() {}
    
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.allowAnalytics)
    public var allowAnalytics = true
    @ACBaseUserDefaults<[String]>(key: UserDefaults.Keys.analyticsViewDays)
    public var viewDays = []
    @ACBaseUserDefaults<Int>(key: UserDefaults.Keys.analyticsArticlesCount)
    public var articleViews = 0

    
    //MARK: Public
    func fetchViewDays() -> [ViewDay] {
        return viewDays.compactMap { decodeViewDay($0) }
    }
    
    func allow(_ newValue: Bool) {
        allowAnalytics = newValue
    }

    func checkAndAddNewViewDay() {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if viewDays.isEmpty {
            addNewViewDay()
            return
        }
        
        if let lastViewDay = decodeViewDay(viewDays.last!), calendar.isDate(currentDate, inSameDayAs: lastViewDay.date) {
            return
        }
        
        addNewViewDay()
    }
    
    func updateCurrentArticleViews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            articleViews+=1
            print("Three minutes have passed!")
        }
    }
}


//MARK: - Main methods
private extension ACCommandsAnalyticsManager {
    
    //MARK: Private
    func addNewViewDay() {
        let currentDate = Date()
        let newViewDay = ViewDay(date: currentDate, articlesCount: articleViews)
        
        if viewDays.count>=7 {
            viewDays.remove(at: 0)
        }
        
        viewDays.append(encodeViewDay(newViewDay)!)
        
        articleViews=0
        
        print("Added new ViewDay: \(newViewDay)")
    }
    
    func decodeViewDay(_ viewDay: String) -> ViewDay? {
        let jsonData = viewDay.data(using: .utf8)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        if let viewDay = try? decoder.decode(ViewDay.self, from: jsonData!) {
            return viewDay
        } else {
            return nil
        }
    }
    
    func encodeViewDay(_ viewDay: ViewDay) -> String? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        if let jsonData = try? encoder.encode(viewDay),
           let jsonString = String(data: jsonData, encoding: .utf8) {
           return jsonString
        } else {
            return nil
        }
    }
}

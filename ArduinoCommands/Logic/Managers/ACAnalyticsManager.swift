//
//  ACCommandsAnalyticsManager.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-07.
//

import Foundation

//MARK: - Manager Injector protocol
protocol AnalyticsManagerInjector {
    var analyticsManager: ACAnalyticsManager { get }
}


//MARK: - Main Manager instance
fileprivate let sharedAnalyticsManager: ACAnalyticsManager = ACAnalyticsManager.shared


//MARK: - Manager Injector protocol extension
extension AnalyticsManagerInjector {
    
    //MARK: Internal
    var analyticsManager: ACAnalyticsManager {
        return sharedAnalyticsManager
    }
}


//MARK: - Analytics Views Update completion Handler
typealias ACAnalyticsViewsUpdateCompletionHandler = ((Bool) -> ())


//MARK: - Manager for Command Views analytics
final public class ACAnalyticsManager {

    //MARK: Static
    static let shared = ACAnalyticsManager()
    
    //MARK: Public
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.Settings.allowAnalytics)
    var allowAnalytics = true
    @ACBaseUserDefaults<[String]>(key: UserDefaults.Keys.Analytics.analyticsViewDays)
    var viewDays = []
    @ACBaseUserDefaults<String>(key: UserDefaults.Keys.Analytics.analyticsLastReadArticle)
    var lastReadArticle = ""
    @ACBaseUserDefaults<Int>(key: UserDefaults.Keys.Analytics.analyticsArticlesCount)
    var articleViews = 0
    @ACBaseUserDefaults<Int>(key: UserDefaults.Keys.Analytics.analyticsDailyGoal)
    var dailyGoal = 3
    

    //MARK: Initialization
    private init() {}

    //MARK: Internal
    func fetchViewDays() -> [ACViewDay] {
        return viewDays.compactMap { decodeViewDay($0) }
    }
    
    func updateLastReadArticle(articleName: String) {
        lastReadArticle = articleName
    }
    
    func setNewDailyGoal(_ newValue: Int) {
        dailyGoal = newValue
    }
    
    func allow(_ newValue: Bool) {
        allowAnalytics = newValue
    }
    
    func checkAndAddNewViewDay() {
        let calendar = Calendar.current
        let currentDate = Date()
        /**
         If a user have launched the app for the first time, and the analytics command views array is empty,
         then we add an element to the analytics array without waiting for a new day.
         */
        if viewDays.isEmpty {
            addNewViewDay()
            return
        }
        /**
         In the code below, in order to add a new element to the analytics command views array
         at the needed period of time (when a new day starts),
         we compare the date property of the last analytics array element with current date.
         */
        if let lastViewDay = decodeViewDay(viewDays.last!), calendar.isDate(currentDate, inSameDayAs: lastViewDay.date) {
            return
        }
        /**
         In the case, when the analytics command views array is not empty, and a new day has already started,
         we append a new number of command articles views to the analytics array when the app would be terminated.
         */
        addNewViewDay()
    }
    
    func updateCurrentArticleViews(completion: @escaping ACAnalyticsViewsUpdateCompletionHandler) {
        /**
         Before we count a new command article view, we make sure that a user has spent
         enough time (2 minutes) to discover a new article.
         */
        if allowAnalytics {
            DispatchQueue.main.asyncAfter(deadline: .now() + 60) { [self] in
                articleViews+=1
                /**
                 
                 */
                completion(articleViews == dailyGoal)
            }
        }
    }
}


//MARK: - Main methods
private extension ACAnalyticsManager {
    
    //MARK: Private
    func addNewViewDay() {
        let currentDate = Date()
        let newViewDay = ACViewDay(date: currentDate, articlesCount: articleViews)
        /**
         In order to present command articles views only for the current week,
         we check if the analytics command views array consists of more than 7 elements,
         and then remove the first element from the analytics command views array.
         */
        if viewDays.count >= 6 {
            viewDays.remove(at: 0)
        }
        
        ///Append a new number of the command article views to the main analytics command views array.
        viewDays.append(encodeViewDay(newViewDay)!)
        
        ///Reset the number of the current command article views.
        articleViews=0
    }
    
    func decodeViewDay(_ viewDay: String) -> ACViewDay? {
        if let jsonData = viewDay.data(using: .utf8),
           let viewDay: ACViewDay = ACJSON.decode(jsonData) {
            return viewDay
        } else {
            return nil
        }
    }
    
    func encodeViewDay(_ viewDay: ACViewDay) -> String? {
        if let jsonData = ACJSON.encode(viewDay),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        } else {
            return nil
        }
    }
}

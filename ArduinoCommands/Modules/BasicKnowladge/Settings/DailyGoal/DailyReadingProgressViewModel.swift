//
//  DailyGoalViewModel.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-27.
//

import Foundation

//MARK: - ViewModel protocol
protocol DailyReadingProgressViewModelProtocol {
    func weekViewDays() -> [ACViewDay]
    func progressRatio(for viewDay: ACViewDay) -> Double
    func weekDayLetter(for viewDay: ACViewDay) -> String
    func articlesCountFooter() -> String
}


//MARK: - Main ViewModel
final class DailyReadingProgressViewModel: ObservableObject, AnalyticsManagerInjector {
    
    //MARK: Public
    @Published var viewDays = [ACViewDay]()
    @Published var articlesCount: Int = 0
    @Published var dailyReadingProgressRatio: Double = 0
    @Published var lastReadArticleName: String = ""
    
    //MARK: Initialization
    init() {
        self.viewDays = analyticsManager.fetchViewDays()
        self.articlesCount = analyticsManager.articleViews
        self.lastReadArticleName = analyticsManager.lastReadArticle.capitalizeFirstLetter()
        self.dailyReadingProgressRatio = countProgressRatio(articlesCount: analyticsManager.articleViews,
                                                            goal: analyticsManager.dailyGoal)
    }
}


//MARK: - ViewModel protocol extension
extension DailyReadingProgressViewModel: DailyReadingProgressViewModelProtocol {
    
    //MARK: Internal
    internal func weekViewDays() -> [ACViewDay] {
        return viewDays.suffix(5)
    }
    
    internal func progressRatio(for viewDay: ACViewDay) -> Double {
        return countProgressRatio(articlesCount: viewDay.articlesCount,
                                  goal: analyticsManager.dailyGoal)
    }
    
    internal func weekDayLetter(for viewDay: ACViewDay) -> String {
        return "\(viewDay.date.firstLetterOfWeekday())"
    }
    
    internal func articlesCountFooter() -> String {
        return "of your \(analyticsManager.dailyGoal) articles goal"
    }
}


//MARK: - Main methods
private extension DailyReadingProgressViewModel {
    
    //MARK: Private
    func countProgressRatio(articlesCount: Int, goal: Int) -> Double {
        let ratio = Double(articlesCount) / Double(goal)
        return ratio > 1 ? 1 : ratio
    }
}

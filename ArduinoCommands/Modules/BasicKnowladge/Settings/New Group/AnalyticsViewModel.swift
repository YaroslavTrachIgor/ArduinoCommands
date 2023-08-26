//
//  AnalyticsViewModel.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-10.
//

import Foundation
import UIKit

//MARK: - ViewModel protocol
protocol AnalyticsViewModelProtocol {
    func onDisappear()
    func countTotalViews() -> Int
    func countDailyAverage() -> Int
    func countMaxDomainValue() -> Int
    func countViewsPercentageGrow() -> Double
    func setupGraphProgressIndicatorImageName() -> String
    func setupGraphProgressIndicatorForegroundColor() -> UIColor
}


//MARK: - Constants
private extension AnalyticsViewModel {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Color {
                
                //MARK: Static
                static let growingIndicatorTint = UIColor.systemGreen
                static let fallingIndicatorTint = UIColor.systemRed
            }
            enum Image {
                
                //MARK: Static
                static let growingIndicatorName = "arrow.up.right"
                static let fallingIndicatorName = "arrow.down.left"
            }
        }
    }
}


//MARK: - Main ViewModel
final class AnalyticsViewModel: ObservableObject, AnalyticsManagerInjector {
    
    //MARK: Public
    @Published var viewDays = [ACViewDay]()
    @Published var dailyGoal: Int = 0
    @Published var articlesCount: Int = 0
    @Published var analyticsAvailable: Bool = true
    @Published var lastReadArticleName: String = ""
    
    //MARK: Initialization
    init() {
        self.viewDays = analyticsManager.fetchViewDays()
        self.dailyGoal = analyticsManager.dailyGoal
        self.articlesCount = analyticsManager.articleViews
        self.analyticsAvailable = analyticsManager.allowAnalytics
    }
}



//MARK: - ViewModel protocol extension
extension AnalyticsViewModel: AnalyticsViewModelProtocol {
    
    //MARK: Internal
    internal func countMaxDomainValue() -> Int {
        let defaultDomain = 6
        let maximumViewsInWeek = viewDays.max(by: { $0 < $1 })?.articlesCount ?? defaultDomain
        return maximumViewsInWeek + 1
    }
    
    internal func countDailyAverage() -> Int {
        let totalViews = viewDays.reduce(0, { $0 + $1.articlesCount })
        let numberOfDays = max(viewDays.count, 1)
        let dailyAverage = Double(totalViews) / Double(numberOfDays)
        let roundedDailyAverage = Int(round(dailyAverage))
        return roundedDailyAverage
    }
    
    internal func setupGraphProgressIndicatorImageName() -> String {
        let growIndicatorImageName = Constants.UI.Image.growingIndicatorName
        let fallIndicatorImageName = Constants.UI.Image.fallingIndicatorName
        let imageName = graphIsGrowing() ? growIndicatorImageName : fallIndicatorImageName
        return imageName
    }
    
    internal func setupGraphProgressIndicatorForegroundColor() -> UIColor {
        let growIndicatorTintColor = Constants.UI.Color.growingIndicatorTint
        let fallIndicatorTintColor = Constants.UI.Color.fallingIndicatorTint
        let graphTintColor = graphIsGrowing() ? growIndicatorTintColor : fallIndicatorTintColor
        return graphTintColor
    }
    
    internal func countTotalViews() -> Int {
        return viewDays.reduce(0, { $0 + $1.articlesCount })
    }
    
    internal func countViewsPercentageGrow() -> Double {
        
        /// Return 0% grow if there is only one articles views count vlaue in the analytics command views array, which also eguals 0.
        if viewDays.count == 1 && viewDays.first!.articlesCount == 0 { return 0 }
        
        /// Return 100% grow if there is only one articles views count vlaue in the analytics command views array.
        if viewDays.count == 1 { return 100 }
        
        /**
         In the case, if the analytics command views array consists of more than two elements,
         and the initial articles count value does not equal to zero,
         we convert the calculated articles views difference to percent value.
         */
        let viewsDiff = calculateArticlesViewsDifference()
        let positiveDiff = viewsDiff > 0 ? viewsDiff / 10 : -viewsDiff
        let percentageChange = positiveDiff * 100
        return percentageChange
    }
    
    internal func onDisappear() {
        /**
         This function will be used in order to update the `UserDefaults` values from the Analytics Manager,
         when a user closes the Analytics screen.
         */
        analyticsManager.setNewDailyGoal(dailyGoal)
        analyticsManager.allow(analyticsAvailable)
    }
}

//MARK: - Main methods
private extension AnalyticsViewModel {
    
    // MARK: Private
    func graphIsGrowing() -> Bool {
        /**
         In order to make graph considered growing if there is only one element in the analytics command views array,
         we make a small check, and we always return true if there is one element in the analytics array,
         and we do an ordinary initial and final articles count difference check in all other cases.
         */
        return viewDays.count == 1 ? true : calculateArticlesViewsDifference() < 0
    }
    
    func calculateArticlesViewsDifference() -> Double {
        guard viewDays.count > 1 else { return 0 }
        let finalCount = Double(viewDays.last!.articlesCount)
        let initialCount = Double(viewDays.first!.articlesCount)
        let checkedInitialCount = initialCount != 0 ? initialCount : 1
        let viewsDiff = (initialCount - finalCount) / checkedInitialCount
        return viewsDiff
    }
}

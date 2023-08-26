//
//  CommandDetailReadingViewModel.swift
//  ArduinoCommands
//
//  Created by User on 2023-08-03.
//

import Foundation

//MARK: - Main ViewModel
final class CommandDetailReadingViewModel {
    
    //MARK: Public
    var model: ACCommand!
    var firstParagraph: String!
    var secondParagraph: String!
    
    
    //MARK: Initialization
    init(model: ACCommand!) {
        self.model = model
        
        let paragraphs = divideIntoTwoParagraphs(article: model.description)
        self.firstParagraph = paragraphs[0]
        self.secondParagraph = paragraphs[1]
    }
}


//MARK: - Main methods
private extension CommandDetailReadingViewModel {
    
    //MARK: Private
    /// Divides the provided article text into two paragraphs, approximately splitting the sentences evenly between them.
    /// If iOS 16.0 is available, the function splits the article into sentences and distributes them between the paragraphs.
    /// If the article has only one sentence, the second paragraph will be empty.
    /// If iOS 16.0 is not available, the entire article is placed in the first paragraph and the second paragraph is empty.
    ///
    /// - Parameter article: The article text to be divided.
    /// - Returns: An array of two strings representing the two paragraphs.
    ///
    /// Example usage:
    /// ```
    /// let articleText = "Lorem ipsum dolor sit amet. Consectetur adipiscing elit. Sed do eiusmod tempor."
    /// let paragraphs = divideIntoTwoParagraphs(article: articleText)
    /// print(paragraphs) // Output: ["Lorem ipsum dolor sit amet.", "Consectetur adipiscing elit. Sed do eiusmod tempor."]
    /// ```
    func divideIntoTwoParagraphs(article: String) -> [String] {
        let emptyParagraph = ""; let separator = "."
        let sentences: [String]
        if #available(iOS 16.0, *) {
            let sentences = article.split(separator: separator).map { String($0) }
            /**
             If there is only one sentence in the article, create an empty second paragraph.
             In all other cases, the function follows the standart procedure of article division.
             */
            if sentences.count == 1 { return [sentences[0], emptyParagraph] }
            let totalCount = sentences.count; let middleIndex = totalCount / 2
            let firstHalf = sentences[..<middleIndex].joined(separator: separator)
            let secondHalf = sentences[middleIndex...].joined(separator: separator)
            let firstParagraph = firstHalf + separator
            let secondParagraph = secondHalf.dropFirst() + separator
            let paragraphs = [String(firstParagraph), String(secondParagraph)]
            return paragraphs
        } else {
            let paragraphs = [article, emptyParagraph]
            return paragraphs
        }
    }
}

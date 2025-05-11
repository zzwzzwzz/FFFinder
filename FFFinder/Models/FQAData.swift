//
//  FQAData.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import Foundation

struct FAQData {
    let question: String
    let answer: String
}

let faqList: [FAQData] = [
    FAQData(
        question: "How do I add a festival to Favorites?",
        answer: "Tap the heart icon on the festival detail page."
    ),
    FAQData(
        question: "Can I search by genre?",
        answer: "Yes, use the filter options to narrow down your results by genre."
    ),
    FAQData(
        question: "How can I view more details about a festival?",
        answer: "Tap on any festival card or list item to view its full description and featured films."
    )
]

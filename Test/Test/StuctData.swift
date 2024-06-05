//
//  StuctData.swift
//  Test
//
//  Created by Hardik Bhut on 05/06/24.
//


import Foundation
struct LoginRequest: Codable {
    
    let email: String
    let password: String
}

struct AnswerChoiceModel: Codable {
    let id: Int
    let text: String
}

struct Inspection: Codable {
    let id: Int
    let name: String
    let answerChoices: [AnswerChoiceModel]
    let selectedAnswerChoiceId: Int
}

struct InspectionSubmitRequest: Codable {
    let inspection: Inspection
}

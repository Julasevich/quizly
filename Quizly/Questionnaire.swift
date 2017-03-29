//
//  Questionnaire.swift
//  Quizly
//
//  Created by John Mottole on 3/27/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import Foundation
class Questionnaire
{
    var id : Int = -1
    var tag : String = " "
    var questionList = [Any]()
    func addQuestion(question : Question) {
        questionList.append(question)
    }
}

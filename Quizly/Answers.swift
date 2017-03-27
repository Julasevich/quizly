//
//  Answers.swift
//  Quizly
//
//  Created by John Mottole on 3/27/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import Foundation
class AnswerSheet
{
    var Answers = [Any]()
    let tag : String!
    var name = " "
    init(t : String)
    {
        tag = t
    }
    
    func setName(n: String)
    {
        name = n
    }

}

class Answer
{
    var id : String = ""
    func setId(i : String)
    {
        id = i
    }
}

class TrueFalseAnswer : Answer
{
    var answer : Bool
    init(ans : Bool)
    {
        answer = ans
    }
}

class MultipleChoiceAnswer : Answer
{
    var answer : String
    init(ans : String)
    {
        answer = " "
    }
}

class ShortAnswerAnswer : Answer
{
    var answer : String
    init(ans : String)
    {
        answer = " "
    }
}

class EssayAnswer : Answer
{
    var answer : String
    init(ans : String)
    {
        answer = " "
    }
}

class MatchingAnswer : Answer
{
    var answer : [String : String]!
    init(ans : [String : String])
    {
        answer = ans
    }
}

class RankingAnswer : Answer
{
    var answer : [String]!
    init(ans : [String])
    {
        answer = ans
    }
}

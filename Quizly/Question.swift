//
//  Question.swift
//  Quizly
//
//  Created by John Mottole on 3/27/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import Foundation
class Question
{
    var prompt : String!
    var tag : String = " "
    init(thePrompt : String)
    {
        prompt = thePrompt
    }
}

class TrueFalseQuestion : Question
{
    override init(thePrompt : String)
    {
        super.init(thePrompt: thePrompt)
        self.tag = "TF"
    }
}

class MultipleChoiceQuestion : Question
{
    var options = [String: String]()
    override init(thePrompt : String)
    {
        super.init(thePrompt: thePrompt)
        self.tag = "MC"
    }
    func addOption(key : String, option: String)
    {
        options[key] = option
    }
}

class shortAnswer : Question
{
    override init(thePrompt : String)
    {
        super.init(thePrompt: thePrompt)
        tag = "SA"
    }
}

class Essay : Question
{
    override init(thePrompt : String)
    {
        super.init(thePrompt: thePrompt)
        tag = "ES"
    }
}

class Matching : Question
{
    var options = [String:String]()
    override init(thePrompt : String)
    {
        super.init(thePrompt: thePrompt)
        tag = "MA"
    }
    func addOptions(left : String, right: String)
    {
        options[left] = right
    }
}

class Ranking : Question
{
    var options = [String]()
    override init(thePrompt : String)
    {
        super.init(thePrompt: thePrompt)
        tag = "RA"
    }
    func addOption(opt : String)
    {
        options.append(opt)
    }
}

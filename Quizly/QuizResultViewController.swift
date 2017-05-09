//
//  QuizResultViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 5/9/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class QuizResultViewController: UIViewController {
    
    var selectedQuestionCode = ""
    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionType = ""
    var resultCode = ""
    var questionDictionary = [String:AnyObject]()
    var resultDictionary = [String:AnyObject]()
    var questionText = ""
    var totalQuestions = 0.0
    var totalCorrect = 0.0
    var grade = 0.0
    var ref: FIRDatabaseReference!

    @IBOutlet weak var resultCodeLabel: UILabel!
    @IBOutlet weak var resultGradeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultCodeLabel.text = "Your result ID: \(resultCode)"
        resultGradeLabel.text = "Calculating Grade"
        getData()
        //calculateGrade
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getData() {
        ref = FIRDatabase.database().reference()
        ref.child("Results").child(resultCode).child(selectedCode).observeSingleEvent(of: .value, with: { (snapshot) in
            if let resultDict = snapshot.value as? [String:AnyObject] {
                self.resultDictionary = resultDict
            }
        })
        
        ref.child(selectedType).child(selectedCode).child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            if let questionDict = snapshot.value as? [String:AnyObject] {
                self.questionDictionary = questionDict
                for question in questionDict {
                    let type = questionDict[question.key]?["type"] as! String
                    if type == "MC" {
                        self.totalQuestions += 1
                        let correctAnswer = questionDict[question.key]?["correct index"]!
                        let answer  = self.resultDictionary[question.key]?["answer"]!
                        if String(describing: answer) == String(describing: correctAnswer) {
                            print("Correct")
                            self.totalCorrect += 1
                        }
                    }else if type == "TF" {
                        self.totalQuestions += 1
                        let correctAnswer = questionDict[question.key]?["correct index"]!
                        let answer  = self.resultDictionary[question.key]?["answer"]!
                        if String(describing: answer) == String(describing: correctAnswer) {
                            print("Correct")
                            self.totalCorrect += 1
                        }
                    }else if type == "SA" {
                        self.totalQuestions += 1
                        let correctAnswer = questionDict[question.key]?["answer"]!
                        let answer  = self.resultDictionary[question.key]?["answer"]!
                        if String(describing: answer).lowercased() == String(describing: correctAnswer).lowercased() {
                            print("Correct")
                            self.totalCorrect += 1
                        }
                    }else if type == "MT" {
                        self.totalQuestions += 1
                        let correctAnswer =  questionDict[question.key]?["right options"] as! NSArray
                        let answer = self.resultDictionary[question.key]?["right options"] as! NSArray
                        if String(describing: correctAnswer) == String(describing: answer) {
                            print("Correct")
                            self.totalCorrect += 1
                        }
                    }else if type == "RA" {
                        self.totalQuestions += 1
                        let correctAnswer =  questionDict[question.key]?["ranks"]!
                        print(correctAnswer)
                        let answer = self.resultDictionary[question.key]?["answer"]!
                        print(answer)
                        if String(describing: correctAnswer) == String(describing: answer) {
                            print("Correct")
                            self.totalCorrect += 1
                        }
                    }
                    
                }
            }
            self.grade = self.totalCorrect / self.totalQuestions
            self.resultGradeLabel.text = "Youre grade is: \(self.grade)"
        })
        
    }

}

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

class QuizResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedQuestionCode = ""
    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionType = ""
    var resultCode = ""
    var questionDictionary = [String:AnyObject]()
    var resultDictionary = [String:AnyObject]()
    var questionCodes = [String]()
    var rightCodes = [String]()
    var questionText = ""
    var totalQuestions = 0.0
    var totalCorrect = 0.0
    var grade = 0.0
    var ref: FIRDatabaseReference!

    @IBOutlet weak var resultCodeLabel: UILabel!
    @IBOutlet weak var resultGradeLabel: UILabel!
    @IBOutlet weak var resultTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeBtn:UIBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(home))
        self.navigationItem.rightBarButtonItems = [homeBtn]
        resultTable.delegate = self
        resultTable.dataSource = self
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Results"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizResultCell", for: indexPath) as! QuizResultCell
            cell.textLabel?.text = "Question \(indexPath.row + 1): \(questionDictionary[questionCodes[indexPath.row]]?["text"] as! String)"
        cell.textLabel?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        if rightCodes.contains(questionCodes[indexPath.row]) {
            cell.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        } else {
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        }
        return cell
    }

    func getData() {
        ref = FIRDatabase.database().reference()
        ref.child("Results").child(resultCode).child(selectedCode).observeSingleEvent(of: .value, with: { (snapshot) in
            if let resultDict = snapshot.value as? [String:AnyObject] {
                self.resultDictionary = resultDict
                //self.resultTable.reloadData()
            }
        })
        
        ref.child(selectedType).child(selectedCode).child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            if let questionDict = snapshot.value as? [String:AnyObject] {
                self.questionDictionary = questionDict
                for question in questionDict {
                    self.questionCodes.append(question.key)
                    let type = questionDict[question.key]?["type"] as! String
                    if type == "MC" {
                        self.totalQuestions += 1
                        let correctAnswer = questionDict[question.key]?["correct index"]!
                        let answer  = self.resultDictionary[question.key]?["answer"]!
                        if String(describing: answer) == String(describing: correctAnswer) {
                            print("Correct")
                            self.rightCodes.append(question.key)
                            self.totalCorrect += 1
                        }
                    }else if type == "TF" {
                        self.totalQuestions += 1
                        let correctAnswer = questionDict[question.key]?["correct index"]!
                        let answer  = self.resultDictionary[question.key]?["answer"]!
                        if String(describing: answer) == String(describing: correctAnswer) {
                            print("Correct")
                            self.rightCodes.append(question.key)
                            self.totalCorrect += 1
                        }
                    }else if type == "SA" {
                        self.totalQuestions += 1
                        let correctAnswer = questionDict[question.key]?["answer"]!
                        let answer  = self.resultDictionary[question.key]?["answer"]!
                        if String(describing: answer).lowercased() == String(describing: correctAnswer).lowercased() {
                            print("Correct")
                            self.rightCodes.append(question.key)
                            self.totalCorrect += 1
                        }
                    }else if type == "MT" {
                        self.totalQuestions += 1
                        let correctAnswer =  questionDict[question.key]?["right options"] as? [String]
                        let answer = self.resultDictionary[question.key]?["right options"] as? [String]
                        if correctAnswer!.elementsEqual(answer!) {
                            print("Correct")
                            self.rightCodes.append(question.key)
                            self.totalCorrect += 1
                        }
                    }else if type == "RA" {
                        self.totalQuestions += 1
                        let correctAnswer =  questionDict[question.key]?["options"]! as! [String]
                        print(correctAnswer)
                        let answer = self.resultDictionary[question.key]?["answer"]! as! [String]
                        print(answer)
                        if correctAnswer.elementsEqual(answer) {
                            print("Correct")
                            self.rightCodes.append(question.key)
                            self.totalCorrect += 1
                        }
                    }
                    
                }
            }
            self.resultTable.reloadData()
            self.grade = self.totalCorrect / self.totalQuestions * 100
            self.resultGradeLabel.text = "Youre grade is: \(Int(self.grade))%.  Reminder, essay question will not be included in your score."
        })
        
    }
    
    func home() {
        self.performSegue(withIdentifier: "resultsToHome", sender: self)
    }

}

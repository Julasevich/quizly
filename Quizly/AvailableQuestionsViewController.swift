//
//  AvailableQuestionsViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/28/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AvailableQuestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionCode = ""
    var selectedQuestionType = ""
    var resultCode = ""
    var questionDictionary = [String:AnyObject]()
    var questionCodes = [String]()
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var availableQuestionsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        print(resultCode)
        //Delegate
        availableQuestionsTable.delegate = self
        availableQuestionsTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Questions"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availableQuestionsCell", for: indexPath) as! AvailableQuestionsTableViewCell
        cell.textLabel?.text = "Question \(indexPath.row + 1): \(questionDictionary[questionCodes[indexPath.row]]?["text"] as! String)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedQuestionCode = questionCodes[indexPath.row]
        selectedQuestionType = questionDictionary[selectedQuestionCode]?["type"]! as! String
        //Conditions here based on question type
        if selectedQuestionType == "MC" {
            self.performSegue(withIdentifier: "availableToMC", sender: self)
            
        } else if selectedQuestionType == "TF" {
            self.performSegue(withIdentifier: "availableToTF", sender: self)
            
        } else if selectedQuestionType == "MT" {
            self.performSegue(withIdentifier: "availableToMA", sender: self)
            
        } else if selectedQuestionType == "RA" {
            self.performSegue(withIdentifier: "availableToRA", sender: self)
            
        } else if selectedQuestionType == "MA" {
            self.performSegue(withIdentifier: "availableToMA", sender: self)
            
        } else if selectedQuestionType == "SA" {
            self.performSegue(withIdentifier: "availableToSA", sender: self)
            
        } else if selectedQuestionType == "ES" {
            self.performSegue(withIdentifier: "availableToES", sender: self)
            
        }
        //self.performSegue(withIdentifier: "", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "availableToMC" {
            let destination = segue.destination as! AnswerMCViewController
            destination.selectedCode = selectedCode
            destination.selectedQuestionCode = selectedQuestionCode
            destination.selectedType = selectedType
            destination.selectedQuestionType = selectedQuestionType
            destination.resultCode = resultCode
        } else if segue.identifier == "availableToTF" {
            let destination = segue.destination as! AnswerTFViewController
            destination.selectedCode = selectedCode
            destination.selectedQuestionCode = selectedQuestionCode
            destination.selectedType = selectedType
            destination.selectedQuestionType = selectedQuestionType
        } else if segue.identifier == "availableToES" {
            let destination = segue.destination as! AnswerESViewController
            destination.selectedCode = selectedCode
            destination.selectedQuestionCode = selectedQuestionCode
            destination.selectedType = selectedType
            destination.selectedQuestionType = selectedQuestionType
        } else if segue.identifier == "availableToSA" {
            let destination = segue.destination as! AnswerSAViewController
            destination.selectedCode = selectedCode
            destination.selectedQuestionCode = selectedQuestionCode
            destination.selectedType = selectedType
            destination.selectedQuestionType = selectedQuestionType
        } else if segue.identifier == "availableToMA" {
            let destination = segue.destination as! AnswerMAViewController
            destination.selectedCode = selectedCode
            destination.selectedQuestionCode = selectedQuestionCode
            destination.selectedType = selectedType
            destination.selectedQuestionType = selectedQuestionType
        } else if segue.identifier == "availableToRA" {
            let destination = segue.destination as! AnswerRAViewController
            destination.selectedCode = selectedCode
            destination.selectedQuestionCode = selectedQuestionCode
            destination.selectedType = selectedType
            destination.selectedQuestionType = selectedQuestionType
        }
    }
    
    func getData() {
        ref = FIRDatabase.database().reference()
        ref.child(selectedType).child(selectedCode).child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            if let questionDict = snapshot.value as? [String:AnyObject] {
                self.questionDictionary = questionDict
                self.availableQuestionsTable.reloadData()
                for question in questionDict {
                    self.questionCodes.append(question.key)
                }
            }
        })
    }
    
    

}

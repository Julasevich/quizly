//
//  CreateQuestionnaireViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateQuestionnaireViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //VARIABLES
    @IBOutlet weak var createQuestionnaireTable: UITableView!
    var surveyDictionary = [String:AnyObject]()
    var surveyCodes = [String]()
    var quizCodes = [String]()
    var quizDictionary = [String:AnyObject]()
    var selectedCode = ""
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        //Delegate
        createQuestionnaireTable.delegate = self
        createQuestionnaireTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Quizes/Tests"
        } else if section == 1 {
            return "Surveys"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return quizDictionary.count
        } else if section == 1 {
            return surveyDictionary.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "createQuestionnaireCell", for: indexPath) as! CreateQuestionnaireTableViewCell
        if indexPath.section == 0 {
            var loopCount = 0
            for quiz in quizDictionary{
                if indexPath.row == loopCount{
                    quizCodes.append(quiz.key)
                    let quizName = quizDictionary[quiz.0]?["title"] as! String
                    cell.textLabel?.text = quizName
                }
                loopCount += 1
            }
        } else if indexPath.section == 1 {
            var loopCount = 0
            for survey in surveyDictionary{
                if indexPath.row == loopCount {
                    surveyCodes.append(survey.key)
                    let surveyName = surveyDictionary[survey.0]?["title"] as! String
                    cell.textLabel?.text = surveyName
                }
                loopCount += 1
            }
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "Add Questionnaire"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedCode = quizCodes[indexPath.row]
            self.performSegue(withIdentifier: "createQuestionnaireToEdit", sender: self)
        } else if indexPath.section == 1 {
            selectedCode = quizCodes[indexPath.row]
            self.performSegue(withIdentifier: "createQuestionnaireToEdit", sender: self)
        } else if indexPath.section == 2 {
            self.performSegue(withIdentifier: "createQuestionnaireToType", sender: self)
        }
        print(selectedCode)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createQuestionnaireToEdit" {
            let destination = segue.destination as! EditQuestionsViewController
            destination.selectedCode = selectedCode
        }
    }
    
    func getData() {
        ref = FIRDatabase.database().reference()
        ref.child("Quiz").observeSingleEvent(of: .value, with: { (snapshot) in
            if let quizDict = snapshot.value as? [String:AnyObject] {
                self.quizDictionary = quizDict
                self.createQuestionnaireTable.reloadData()
            }
        })
        ref.child("Survey").observeSingleEvent(of: .value, with: { (snapshot) in
            if let surveyDict = snapshot.value as? [String:AnyObject] {
                self.surveyDictionary = surveyDict
                self.createQuestionnaireTable.reloadData()
            }
        })
    }
    

}

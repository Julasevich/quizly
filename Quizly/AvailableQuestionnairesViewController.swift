//
//  AvailableQuestionnairesViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AvailableQuestionnairesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var availableQuestionnairesTable: UITableView!
    var surveyDictionary = [String:AnyObject]()
    var quizDictionary = [String:AnyObject]()
    var selectedType = ""
    var selectedCode = ""
    var surveyCodes = [String]()
    var quizCodes = [String]()
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        //Delegate
        availableQuestionnairesTable.delegate = self
        availableQuestionnairesTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Quizes"
        } else {
            return "Surveys"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if quizDictionary.count == 0 {
                return 1
            } else {
                return quizDictionary.count
            }
        } else {
            if surveyDictionary.count == 0 {
                return 1
            } else {
                return surveyDictionary.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availableQuestionnaires", for: indexPath) as! AvailableQuestionnairesTableViewCell
        print(quizDictionary)
        print(surveyDictionary)
        if indexPath.section == 0 {
            if quizDictionary.count == 0 {
                cell.textLabel?.text = "None Available"
            } else {
                var loopCount = 0
                for quiz in quizDictionary{
                    if indexPath.row == loopCount {
                        quizCodes.append(quiz.key)
                        let quizName = quizDictionary[quiz.0]?["title"] as! String
                        cell.textLabel?.text = quizName
                    }
                    loopCount += 1
                }
            }
        } else if indexPath.section == 1 {
            if surveyDictionary.count == 0 {
                cell.textLabel?.text = "None Available"
            } else {
                var loopCount = 0
                for survey in surveyDictionary{
                    if indexPath.row == loopCount {
                        surveyCodes.append(survey.key)
                        let surveyName = surveyDictionary[survey.0]?["title"] as! String
                        cell.textLabel?.text = surveyName
                    }
                    loopCount += 1
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedCode = quizCodes[indexPath.row]
            selectedType = "Quiz"
            self.performSegue(withIdentifier: "availableToQuestions", sender: self)
        } else if indexPath.section == 1 {
            selectedCode = surveyCodes[indexPath.row]
            selectedType = "Survey"
            self.performSegue(withIdentifier: "availableToQuestions", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "availableToQuestions" {
            let destination = segue.destination as! AvailableQuestionsViewController
            destination.selectedCode = selectedCode
            destination.selectedType = selectedType
        }
    }
    
    func getData() {
        ref = FIRDatabase.database().reference()
        ref.child("Quiz").observeSingleEvent(of: .value, with: { (snapshot) in
            if let quizDict = snapshot.value as? [String:AnyObject] {
                self.quizDictionary = quizDict
                self.availableQuestionnairesTable.reloadData()
            }
        })
        ref.child("Survey").observeSingleEvent(of: .value, with: { (snapshot) in
            if let surveyDict = snapshot.value as? [String:AnyObject] {
                self.surveyDictionary = surveyDict
                self.availableQuestionnairesTable.reloadData()
            }
        })
    }

}

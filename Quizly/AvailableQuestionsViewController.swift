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
    var questionDictionary = [String:AnyObject]()
    var questionCodes = [String]()
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var availableQuestionsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
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
        cell.textLabel?.text = "Question \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedQuestionCode = questionCodes[indexPath.row]
        selectedType = questionDictionary[selectedQuestionCode]?["type"]! as! String
        //Conditions here based on question type
        if selectedType == "MC" {
            self.performSegue(withIdentifier: "availableToMC", sender: self)
            
        } else if selectedType == "TF" {
            self.performSegue(withIdentifier: "availableToTF", sender: self)
            
        } else if selectedType == "MT" {
            self.performSegue(withIdentifier: "availableToMA", sender: self)
            
        } else if selectedType == "RA" {
            self.performSegue(withIdentifier: "availableToRA", sender: self)
            
        } else if selectedType == "MA" {
            self.performSegue(withIdentifier: "availableToMA", sender: self)
            
        } else if selectedType == "SA" {
            self.performSegue(withIdentifier: "availableToSA", sender: self)
            
        } else if selectedType == "ES" {
            self.performSegue(withIdentifier: "availableToES", sender: self)
            
        }
        //self.performSegue(withIdentifier: "", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            let destination = segue.destination as! EditQuestionTextViewController
            destination.selectedCode = selectedCode
            destination.selectedType = selectedType
            destination.selectedQuestionCode = selectedQuestionCode
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

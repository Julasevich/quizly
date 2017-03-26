//
//  EditQuestionsViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/26/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EditQuestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var editQuestionnaireTable: UITableView!
    var selectedCode = ""
    var selectedType = ""
    var questionDictionary = [String:AnyObject]()
    var ref: FIRDatabaseReference!


    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        //Delegate
        editQuestionnaireTable.delegate = self
        editQuestionnaireTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Edit Quiz"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editQuestionCell", for: indexPath) as! EditQuestionsTableViewCell
        cell.textLabel?.text = "Question \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == questionDictionary.count {
            self.performSegue(withIdentifier: "addQuestionToSelectType", sender: self)
        }
        
    }
    
    func getData() {
        ref = FIRDatabase.database().reference()
        ref.child(selectedType).child(selectedCode).child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            if let questionDict = snapshot.value as? [String:AnyObject] {
                self.questionDictionary = questionDict
                self.editQuestionnaireTable.reloadData()
            }
        })
    }
}

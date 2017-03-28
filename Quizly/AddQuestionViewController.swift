//
//  AddQuestionViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //VARIABLES
    @IBOutlet weak var addQuestionTable: UITableView!
    var questionDictionary = [String:AnyObject]()
    var questionnaireType = ""
    var questionnaireID = ""
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        print("ID \(questionnaireID)")
        //Delegate
        addQuestionTable.delegate = self
        addQuestionTable.dataSource = self
        
        let doneBtn:UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(returnToQuestionaaireList))
        self.navigationItem.rightBarButtonItems = [doneBtn]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnToQuestionaaireList()
    {
        self.performSegue(withIdentifier: "addQuestionToShowAvailableQuestionnaires", sender: self)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Edit Quiz"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionDictionary.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addQuestionCell", for: indexPath) as! AddQuestionTableViewCell
        if indexPath.row != questionDictionary.count{
            //Question Cell
            cell.textLabel?.text = "Question \(indexPath.row + 1)"
        } else {
            //Add Question Cell
            cell.textLabel?.text = "Add Question"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == questionDictionary.count {
            self.performSegue(withIdentifier: "addQuestionToSelectType", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addQuestionToSelectType" {
            let destination = segue.destination as! QuestionTypeViewController
            destination.questionnaireType = self.questionnaireType
            destination.questionCount = questionDictionary.count
            destination.questionnaireID = self.questionnaireID
        }
    }
    
    func getData() {
        ref = FIRDatabase.database().reference()
        ref.child("Quiz or Test").child(questionnaireID).child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            if let questionDict = snapshot.value as? [String:AnyObject] {
                self.questionDictionary = questionDict
                self.addQuestionTable.reloadData()
            }
        })
    }

}

//
//  CreateMultipleChoiceViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/24/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateMultipleChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var createMCTable: UITableView!
    var options = [String]()
    var questionText = ""
    var questionnaireType = ""
    var questionCount = 0
    var questionnaireID = ""
    var questionID = ""
    var ref: FIRDatabaseReference!
    var editingMode = false
    var correctRow = 0
    var start = true
    override func viewDidLoad() {
        super.viewDidLoad()
        print(questionnaireType)
        print(questionText)
        print(questionCount)
        //Right Buttons
        let addBtn:UIBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addQuestion))
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOptions))
        self.navigationItem.rightBarButtonItems = [addBtn, saveBtn]
        
        //Delegate
        createMCTable.delegate = self
        createMCTable.dataSource = self
        
        print(options)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Edit Options"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != options.count{
            //Question Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "createMCCell", for: indexPath) as! CreateMultipleChoiceTableViewCell
            if start == false {
                options[indexPath.row] = cell.optionTF.text!
            }else {
                cell.optionTF.text = options[indexPath.row]
                
            }
            if indexPath.row == options.count-1
            {
                start = false
            }
            if questionnaireType == "Quiz" {
                if correctRow == indexPath.row {
                    cell.correctLabel.backgroundColor = UIColor.green
                } else {
                    cell.correctLabel.backgroundColor = UIColor.white
                }
            }
            return cell
        } else {
            //Add Question Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "addAnswerCell", for: indexPath)
            cell.textLabel?.text = "Add Answer"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == options.count {
            createMCTable.beginUpdates()
            createMCTable.insertRows(at: [IndexPath(row: options.count, section:0)], with: .automatic)
            options.append("")
            createMCTable.endUpdates()
            createMCTable.reloadData()
        } else {
            correctRow = indexPath.row
            createMCTable.reloadData()
        }
    }
    
    func addQuestion() {
        //Save Options
        ref = FIRDatabase.database().reference()
        if editingMode == false{
            questionID = createID()
        }
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("text").setValue(questionText)
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("options").setValue(options)
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("type").setValue("MC")
        if questionnaireType == "Quiz" {
            self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("correct index").setValue(correctRow)
        }
        if editingMode == false{
            self.performSegue(withIdentifier: "addMCToAddQuestion", sender: self)
        }else {
            self.performSegue(withIdentifier: "addMCToHome", sender: self)
        }
    }
    
    func saveOptions() {
        createMCTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMCToAddQuestion" {
            let destination = segue.destination as! AddQuestionViewController
            destination.questionnaireID = questionnaireID
            destination.questionnaireType = questionnaireType
        }
    }
    
    func createID() -> String {
        var i = 0
        var id = ""
        while i < 10 {
            let randomNum:UInt32 = arc4random_uniform(9)
            id += String(randomNum)
            i += 1
        }
        return id
    }
}

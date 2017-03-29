//
//  CreateRAViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/24/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateRAViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var createRATable: UITableView!
    var questionText = ""
    var ref: FIRDatabaseReference!
    var options = [String]()
    var ranks = [String]()
    var questionID = ""
    var questionnaireType = ""
    var questionnaireID = ""
    var editingMode = false
    var start = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Right Buttons
        let addBtn:UIBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addQuestion))
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOptions))
        self.navigationItem.rightBarButtonItems = [addBtn, saveBtn]
        
        //Delegate
        createRATable.delegate = self
        createRATable.dataSource = self
        print(ranks)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "createRACell", for: indexPath) as! CreateRATableViewCell
            if start == false
            {
                options[indexPath.row] = cell.optionTF.text!
                ranks[indexPath.row] = cell.rankTF.text!
            } else {
                cell.optionTF.text = options[indexPath.row]
                cell.rankTF.text = ranks[indexPath.row]
            }
            
            if indexPath.row == options.count-1
            {
                start = false
            }
            
            if questionnaireType == "Survey" {
                cell.rankTF.isHidden = true
                cell.rankLabel.isHidden = true
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
            createRATable.beginUpdates()
            createRATable.insertRows(at: [IndexPath(row: options.count, section:0)], with: .automatic)
            options.append("")
            ranks.append("")
            createRATable.endUpdates()
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
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("type").setValue("RA")
        if questionnaireType == "Quiz" {
            self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("ranks").setValue(ranks)
        }
        self.performSegue(withIdentifier: "addRAToAddQuestion", sender: self)
    }
    
    func saveOptions() {
        createRATable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addRAToAddQuestion" {
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

//
//  CreateTFViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/24/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateTFViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var createTFTable: UITableView!
    var questionText = ""
    var ref: FIRDatabaseReference!
    var questionID = ""
    var questionnaireType = ""
    var questionnaireID = " "
    var correctRow = 0
    var editingMode = false
    var dictFromFirebase = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Right Buttons
        let addBtn:UIBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addQuestion))
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOptions))
        self.navigationItem.rightBarButtonItems = [addBtn, saveBtn]

        //Delegate
        createTFTable.delegate = self
        createTFTable.dataSource = self
        
        
       if editingMode == true
       {
        
        }
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "createTFCell", for: indexPath) as! CreateTFTableViewCell
        if indexPath.row == 0{
            //Question Cell
            cell.answerLabel?.text = "True"
        } else {
            //Add Question Cell
            cell.answerLabel?.text = "False"
        }
        if questionnaireType == "Quiz" {
            if correctRow == indexPath.row {
                cell.correctLabel.backgroundColor = UIColor.green
            } else {
                cell.correctLabel.backgroundColor = UIColor.white
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        correctRow = indexPath.row
        createTFTable.reloadData()
    }
    
    func addQuestion() {
        //Save Options
        ref = FIRDatabase.database().reference()
        print(editingMode)
        if editingMode == false
        {
            questionID = createID()
        }
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("text").setValue(questionText)
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("options").setValue(["True", "False"])
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("type").setValue("TF")
        if questionnaireType == "Quiz" {
            self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("correct index").setValue(correctRow)
        }
        if editingMode == false{
            self.performSegue(withIdentifier: "addTFToAddQuestion", sender: self)
        }else
        {
            self.performSegue(withIdentifier: "createTFtoHome", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTFToAddQuestion" {
            let destination = segue.destination as! AddQuestionViewController
            destination.questionnaireID = questionnaireID
            destination.questionnaireType = questionnaireType
        }
    }
    
    func saveOptions() {
        createTFTable.reloadData()
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

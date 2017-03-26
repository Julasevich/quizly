//
//  CreateMTViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/24/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateMTViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var createMTTable: UITableView!
    var questionText = ""
    var ref: FIRDatabaseReference!
    var leftOptions = [String]()
    var rightOptions = [String]()
    var questionID = ""
    var questionnaireType = ""
    var questionnaireID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Right Buttons
        let addBtn:UIBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addQuestion))
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOptions))
        self.navigationItem.rightBarButtonItems = [addBtn, saveBtn]
        
        //Delegate
        createMTTable.delegate = self
        createMTTable.dataSource = self
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
        return leftOptions.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != leftOptions.count{
            //Question Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "createMTCell", for: indexPath) as! CreateMTTableViewCell
            leftOptions[indexPath.row] = cell.leftTF.text!
            rightOptions[indexPath.row] = cell.rightTF.text!
            return cell
        } else {
            //Add Question Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "addAnswerCell", for: indexPath) 
            cell.textLabel?.text = "Add Answer"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == leftOptions.count {
            createMTTable.beginUpdates()
            createMTTable.insertRows(at: [IndexPath(row: leftOptions.count, section:0)], with: .automatic)
            leftOptions.append("")
            rightOptions.append("")
            createMTTable.endUpdates()
            createMTTable.reloadData()
        }
        
    }
    
    func addQuestion() {
        //Save Options
        ref = FIRDatabase.database().reference()
        questionID = createID()
 
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("text").setValue(questionText)
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("left options").setValue(leftOptions)
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("right options").setValue(rightOptions)
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("type").setValue("MT")
        self.performSegue(withIdentifier: "addMTToAddQuestion", sender: self)
    }
    
    func saveOptions() {
        createMTTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMTToAddQuestion" {
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

//
//  AnswerRAViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 5/7/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AnswerRAViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var dataTable: UITableView!
    var selectedQuestionCode = ""
    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionType = ""
    var questionDictionary = [String:AnyObject]()
    var optionsArray = [String]()
    var questionText = ""
    var resultCode = ""
    var ref: FIRDatabaseReference!
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOption))
        let answerBtn:UIBarButtonItem = UIBarButtonItem(title: "Answer", style: .plain, target: self, action: #selector(answerQuestion))
        self.navigationItem.rightBarButtonItems = [answerBtn, saveBtn]
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.setEditing(true, animated: true)
        getData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let holder = optionsArray[sourceIndexPath.row]
        optionsArray.remove(at: sourceIndexPath.row)
        optionsArray.insert(holder, at: destinationIndexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = optionsArray[indexPath.row]
        return cell
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getData() {
        print(FIRDatabase.database().reference())
        
        ref = FIRDatabase.database().reference()
        ref.child(selectedType).child(selectedCode).child("questions").child(selectedQuestionCode).observeSingleEvent(of: .value, with: { (snapshot) in
            if let questionDict = snapshot.value as? [String:AnyObject] {
                self.questionDictionary = questionDict
                self.optionsArray = questionDict["options"] as! [String]
                self.questionTextView.text  = self.questionDictionary["text"] as! String
                self.dataTable.reloadData()
                for question in questionDict {
                    //self.questionCodes.append(question.key)
                }
            }
        })
    }
    
    func saveOption() {
        dataTable.reloadData()
        
    }
    
    func answerQuestion() {
        ref = FIRDatabase.database().reference()
        self.ref.child("Results").child(resultCode).child(selectedCode).child(selectedQuestionCode).child("answer").setValue(optionsArray)
        self.navigationController?.popViewController(animated: true)
    }

}

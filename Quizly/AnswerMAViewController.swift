//
//  AnswerMAViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 5/7/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AnswerMAViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var optionsTable: UITableView!
    @IBOutlet weak var optionsTable2nd: UITableView!
    var selectedQuestionCode = ""
    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionType = ""
    var questionDictionary = [String:AnyObject]()
    var questionText = ""
    var resultCode = ""
    var ref: FIRDatabaseReference!
    var selectedRow = 0
    var leftArray = [String]()
    var rightArray = [String]()
    @IBOutlet weak var questionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOption))
        let answerBtn:UIBarButtonItem = UIBarButtonItem(title: "Answer", style: .plain, target: self, action: #selector(answerQuestion))
        self.navigationItem.rightBarButtonItems = [answerBtn, saveBtn]
        optionsTable.delegate = self
        optionsTable.dataSource = self
        optionsTable.setEditing(true, animated: true)
        optionsTable2nd.delegate = self
        optionsTable2nd.dataSource = self
        optionsTable2nd.setEditing(true, animated: true)
        getData()

        // Do any additional setup after loading the view.
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
        if (tableView == optionsTable)
        {
            let holder = leftArray[sourceIndexPath.row]
            leftArray.remove(at: sourceIndexPath.row)
            leftArray.insert(holder, at: destinationIndexPath.row)
        } else {
            let holder = rightArray[sourceIndexPath.row]
            rightArray.remove(at: sourceIndexPath.row)
            rightArray.insert(holder, at: destinationIndexPath.row)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableView == optionsTable {
            cell.textLabel?.text = leftArray[indexPath.row]
        } else
        {
            cell.textLabel?.text = rightArray[indexPath.row]

        }
        return cell
    }

    
    
    func getData() {
        print(FIRDatabase.database().reference())
        
        ref = FIRDatabase.database().reference()
        ref.child(selectedType).child(selectedCode).child("questions").child(selectedQuestionCode).observeSingleEvent(of: .value, with: { (snapshot) in
            if let questionDict = snapshot.value as? [String:AnyObject] {
                self.questionDictionary = questionDict
                self.questionTextView.text  = self.questionDictionary["text"] as! String
                self.leftArray = questionDict["left options"] as! [String]
                self.rightArray = questionDict["right options"] as! [String]
                self.optionsTable.reloadData()
                self.optionsTable2nd.reloadData()
                for question in questionDict {
                    //self.questionCodes.append(question.key)
                }
            }
        })
    }
    
    func saveOption() {
        optionsTable.reloadData()
        optionsTable2nd.reloadData()

        
    }
    
    func answerQuestion() {
        ref = FIRDatabase.database().reference()
        self.ref.child("Results").child(resultCode).child(selectedCode).child(selectedQuestionCode).child("answer").child("left options").setValue(leftArray)
        self.ref.child("Results").child(resultCode).child(selectedCode).child(selectedQuestionCode).child("answer").child("right options").setValue(rightArray)
        self.navigationController?.popViewController(animated: true)
    }

}

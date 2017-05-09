//
//  AnswerTFViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 5/7/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AnswerTFViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var selectedQuestionCode = ""
    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionType = ""
    var questionText = ""
    var ref: FIRDatabaseReference!
    var selectedRow = 1
    var resultCode = ""
    var questionDictionary = [String:AnyObject]()
    @IBOutlet var optionsTable: UITableView!
    @IBOutlet weak var questionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        optionsTable.delegate = self
        optionsTable.dataSource = self
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOption))
        let answerBtn:UIBarButtonItem = UIBarButtonItem(title: "Answer", style: .plain, target: self, action: #selector(answerQuestion))
        self.navigationItem.rightBarButtonItems = [answerBtn, saveBtn]
        print("GET DATA")
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "TFAnswerCell", for: indexPath) as! AnswerTFTableViewCell
            if indexPath.row == 0
            {
                cell.theTextLabel.text = "True"
            } else {
                cell.theTextLabel.text = "False"
            }
            if selectedRow == indexPath.row {
                cell.chosen.backgroundColor = UIColor.green
            } else
            {
                cell.chosen.backgroundColor = UIColor.clear
            }
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        optionsTable.reloadData()
        
        
    }

    
    

    func getData() {
        print(FIRDatabase.database().reference())
        
        ref = FIRDatabase.database().reference()
        ref.child(selectedType).child(selectedCode).child("questions").child(selectedQuestionCode).observeSingleEvent(of: .value, with: { (snapshot) in
            if let questionDict = snapshot.value as? [String:AnyObject] {
                self.questionDictionary = questionDict
                self.optionsTable.reloadData()
                self.questionTextView.text  = self.questionDictionary["text"] as! String
                for question in questionDict {
                    //self.questionCodes.append(question.key)
                }
            }
        })
    }
    
    func saveOption() {
        optionsTable.reloadData()
        
    }
    
    func answerQuestion() {
        ref = FIRDatabase.database().reference()
        self.ref.child("Results").child(resultCode).child(selectedCode).child(selectedQuestionCode).child("answer").setValue(selectedRow)
        self.navigationController?.popViewController(animated: true)
    }
    

}

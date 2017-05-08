//
//  AnswerMCViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 5/7/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AnswerMCViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var optionsTable: UITableView!
    var selectedQuestionCode = ""
    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionType = ""
    var questionDictionary = [String:AnyObject]()
    var questionText = ""
    var ref: FIRDatabaseReference!
    var selectedRow = 0

    @IBOutlet weak var questionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsTable.delegate = self
        optionsTable.dataSource = self
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Options"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var i = 1
        if let options = questionDictionary["options"] as? NSArray
        {
            i = options.count
        }
        return i
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let options = questionDictionary["options"] as? NSArray
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MCAnswerCell", for: indexPath) as! AnswerMCTableViewCell
            cell.labelText.text = "\(options.object(at: indexPath.row))"
            if selectedRow == indexPath.row {
                cell.correctLabel.backgroundColor = UIColor.green
            } else
            {
                cell.correctLabel.backgroundColor = UIColor.clear
            }
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "MCAnswerCell", for: indexPath) as! AnswerMCTableViewCell
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

}

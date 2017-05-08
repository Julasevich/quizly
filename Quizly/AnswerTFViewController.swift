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
    @IBOutlet var optionsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        optionsTable.delegate = self
        optionsTable.dataSource = self
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
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "TFAnswerCell", for: indexPath) as! AnswerTFTableViewCell
            if indexPath.row == 0
            {
                cell.theTextLabel.text = questionText
            } else if indexPath.row == 1
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
        if indexPath.row != 0
        {
            selectedRow = indexPath.row
            optionsTable.reloadData()
        }
        
    }

    
    

    func getData() {
        print(FIRDatabase.database().reference())
        ref = FIRDatabase.database().reference()
        print(selectedType)
        print(selectedCode)

        print(selectedQuestionCode)

        ref.child(selectedType).child(selectedCode).child("questions").child(selectedQuestionCode).observeSingleEvent(of: .value, with: { (snapshot) in
            if let questionDict = snapshot.value as? [String:AnyObject] {
                self.questionText  = questionDict["text"] as! String
                self.optionsTable.reloadData()
            }
        })

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

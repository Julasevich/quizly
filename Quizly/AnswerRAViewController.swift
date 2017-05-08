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

class AnswerRAViewController: UIViewController {

    @IBOutlet weak var questionTextView: UITextView!
    var selectedQuestionCode = ""
    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionType = ""
    var questionDictionary = [String:AnyObject]()
    var questionText = ""
    var resultCode = ""
    var ref: FIRDatabaseReference!
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOption))
        let answerBtn:UIBarButtonItem = UIBarButtonItem(title: "Answer", style: .plain, target: self, action: #selector(answerQuestion))
        self.navigationItem.rightBarButtonItems = [answerBtn, saveBtn]
        getData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                self.questionTextView.text  = self.questionDictionary["text"] as! String
                for question in questionDict {
                    //self.questionCodes.append(question.key)
                }
            }
        })
    }
    
    func saveOption() {
        //optionsTable.reloadData()
        
    }
    
    func answerQuestion() {
        ref = FIRDatabase.database().reference()
        self.navigationController?.popViewController(animated: true)
    }

}

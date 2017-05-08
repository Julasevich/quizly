//
//  AnswerESViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 5/7/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AnswerESViewController: UIViewController {
    
    var selectedQuestionCode = ""
    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionType = ""
    var questionDictionary = [String:AnyObject]()
    var questionText = ""
    var resultCode = ""
    var ref: FIRDatabaseReference!

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOption))
        let answerBtn:UIBarButtonItem = UIBarButtonItem(title: "Answer", style: .plain, target: self, action: #selector(answerQuestion))
        self.navigationItem.rightBarButtonItems = [answerBtn, saveBtn]
        getData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
        
    }
    
    func answerQuestion() {
        ref = FIRDatabase.database().reference()
        self.ref.child("Results").child(resultCode).child(selectedCode).child(selectedQuestionCode).child("answer").setValue(answerTextView.text)
        self.navigationController?.popViewController(animated: true)
    }

}

//
//  AnswerSAViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 5/7/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AnswerSAViewController: UIViewController {
    
    var selectedQuestionCode = ""
    var selectedCode = ""
    var selectedType = ""
    var selectedQuestionType = ""
    var questionDictionary = [String:AnyObject]()
    var questionText = ""
    var ref: FIRDatabaseReference!
    
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

        // Do any additional setup after loading the view.
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

}

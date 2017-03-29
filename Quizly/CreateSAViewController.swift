//
//  CreateSAViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/24/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateSAViewController: UIViewController {
    
    @IBOutlet weak var charLimitTF: UITextField!
    var questionText = ""
    var ref: FIRDatabaseReference!
    var questionID = ""
    var questionnaireType = ""
    var questionnaireID = ""
    var correctAns = ""
    var editingMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Right Buttons
        let addBtn:UIBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addQuestion))
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveOptions))
        self.navigationItem.rightBarButtonItems = [addBtn, saveBtn]
        if editingMode == true {
            charLimitTF.text = correctAns
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addQuestion() {
        //Save Options
        ref = FIRDatabase.database().reference()
        if editingMode == false
        {
            questionID = createID()
        }
        
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("text").setValue(questionText)
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("answer").setValue(correctAns)
        self.ref.child(questionnaireType).child(questionnaireID).child("questions").child(questionID).child("type").setValue("SA")
        if editingMode == false
        {
            self.performSegue(withIdentifier: "addSAToAddQuestion", sender: self)
        } else {
            self.performSegue(withIdentifier: "addSAToHome", sender: self)
        }
    }
    
    func saveOptions() {
        correctAns = charLimitTF.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSAToAddQuestion" {
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

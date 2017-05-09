//
//  EditQuestionTextViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/27/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EditQuestionTextViewController: UIViewController {

    @IBOutlet weak var questionTextTV: UITextView!
    var ref: FIRDatabaseReference!
    var questionText = ""
    var selectedCode = ""
    var selectedQuestionCode = ""
    var selectedType = ""
    var questionInfo = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        //Right Buttons
        let addBtn:UIBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextSection))
        let saveBtn:UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveText))
        self.navigationItem.rightBarButtonItems = [addBtn, saveBtn]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func getData() {
        ref = FIRDatabase.database().reference()
        ref.child(selectedType).child(selectedCode).child("questions").child(selectedQuestionCode).child("text").observeSingleEvent(of: .value, with: { (snapshot) in
            self.questionText = snapshot.value as! String
            self.questionTextTV.text = self.questionText
        })
        ref.child(selectedType).child(selectedCode).child("questions").child(selectedQuestionCode).observeSingleEvent(of: .value, with: { (snapshot) in
            self.questionInfo = snapshot.value! as! NSDictionary
        })
    }
    
    func nextSection() {
        let qType = questionInfo.value(forKey: "type")! as! String
        if qType == "TF"
        {
            performSegue(withIdentifier: "editQuestionTexttoCreateTF", sender: self)
        }
        if qType == "MC"
        {
            performSegue(withIdentifier: "editQuestionTexttoCreateMC", sender: self)
        }
        if qType == "MT"
        {
            performSegue(withIdentifier: "editQuestionTexttoCreateMT", sender: self)
        }
        if qType == "RA"
        {
            performSegue(withIdentifier: "editQuestionTexttoCreateRA", sender: self)
        }
        if qType == "SA"
        {
            performSegue(withIdentifier: "editQuestionTexttoCreateSA", sender: self)
        }
        if qType == "ES"
        {
            performSegue(withIdentifier: "editQuestionTexttoHome", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editQuestionTexttoCreateTF" {
            let dest = segue.destination as! CreateTFViewController
            dest.questionnaireID = selectedCode
            if (selectedType == "Quiz")
            {
                dest.correctRow = questionInfo.value(forKey: "correct index")! as! Int
            }
            dest.questionID = selectedQuestionCode
            dest.questionnaireType = selectedType
            dest.questionText = questionTextTV.text
            dest.editingMode = true
        }
        if segue.identifier == "editQuestionTexttoCreateMC" {
            let dest = segue.destination as! CreateMultipleChoiceViewController
            dest.questionnaireID = selectedCode
            if (selectedType == "Quiz")
            {
                dest.correctRow = questionInfo.value(forKey: "correct index")! as! Int
            }
            dest.questionID = selectedQuestionCode
            dest.questionnaireType = selectedType
            dest.questionText = questionTextTV.text
            dest.editingMode = true
            dest.options = questionInfo.value(forKey: "options")! as! [String]
        }
        if segue.identifier == "editQuestionTexttoCreateMT" {
            let dest = segue.destination as! CreateMTViewController
            dest.questionnaireID = selectedCode
            if (selectedType == "Quiz")
            {
                dest.leftOptions = questionInfo.value(forKey: "left options")! as! [String]
                dest.rightOptions = questionInfo.value(forKey: "right options")! as! [String]
            }
            dest.questionID = selectedQuestionCode
            dest.questionnaireType = selectedType
            dest.questionText = questionTextTV.text
            dest.editingMode = true
        }
        if segue.identifier == "editQuestionTexttoCreateRA" {
            let dest = segue.destination as! CreateRAViewController
            dest.questionnaireID = selectedCode
            if (selectedType == "Quiz")
            {
                dest.options = questionInfo.value(forKey: "options")! as! [String]
                
            }
            dest.questionID = selectedQuestionCode
            dest.questionnaireType = selectedType
            dest.questionText = questionTextTV.text
            dest.editingMode = true
        }
        if segue.identifier == "editQuestionTexttoCreateSA" {
            let dest = segue.destination as! CreateSAViewController
            dest.questionnaireID = selectedCode
            if (selectedType == "Quiz")
            {
                dest.correctAns = questionInfo.value(forKey: "answer")! as! String
            }
            dest.questionID = selectedQuestionCode
            dest.questionnaireType = selectedType
            dest.questionText = questionTextTV.text
            dest.editingMode = true
        }
    }
    
    func saveText() {
        ref = FIRDatabase.database().reference()
        ref.child(selectedType).child(selectedCode).child("questions").child(selectedQuestionCode).child("text").setValue(self.questionTextTV.text)
    }
    
}

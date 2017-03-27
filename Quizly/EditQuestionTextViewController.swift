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
    }
    
    func nextSection() {
        
    }
    
    func saveText() {
        ref = FIRDatabase.database().reference()
        ref.child(selectedType).child(selectedCode).child("questions").child(selectedQuestionCode).child("text").setValue(self.questionTextTV.text)
    }
}

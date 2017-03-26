//
//  TitleViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TitleViewController: UIViewController {
    

    @IBOutlet weak var titleTF: UITextField!
    var ref: FIRDatabaseReference!
    var questionnaireType = ""
    var questionnaireID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueActnBtn(_ sender: Any) {
        ref = FIRDatabase.database().reference()
        self.questionnaireID = createID()
        self.ref.child(questionnaireType).child(questionnaireID).child("title").setValue(titleTF.text)
        self.performSegue(withIdentifier: "titleToCreateMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "titleToCreateMain" {
            let destination = segue.destination as! AddQuestionViewController
            destination.questionnaireType = self.questionnaireType
            destination.questionnaireID = self.questionnaireID
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

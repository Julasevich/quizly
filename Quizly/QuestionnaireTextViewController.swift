//
//  QuestionnaireTextViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/24/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class QuestionnaireTextViewController: UIViewController {
    
    //VARIABLES
    var questionType = ""
    var questionnaireType = ""
    var questionCount = 0
    var questionnaireID = ""
    @IBOutlet weak var questionTextTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Right Button
        let rightBtn:UIBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(goNext))
        self.navigationItem.setRightBarButton(rightBtn, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //FUNCTIONS
    func goNext() {
        if questionType == "MC" {
            self.performSegue(withIdentifier: "textToEditMC", sender: self)
        } else if questionType == "TF" {
            self.performSegue(withIdentifier: "textToEditTF", sender: self)
        } else if questionType == "MT" {
            self.performSegue(withIdentifier: "textToEditMT", sender: self)
        } else if questionType == "RA" {
            self.performSegue(withIdentifier: "textToEditRA", sender: self)
        } else if questionType == "SA" {
            self.performSegue(withIdentifier: "textToEditSA", sender: self)
        } else if questionType == "ES" {
            self.performSegue(withIdentifier: "textToEditES", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "textToEditMC" {
            let destination = segue.destination as! CreateMultipleChoiceViewController
            destination.questionText = questionTextTV.text
            destination.questionnaireType = questionnaireType
            destination.questionnaireID = self.questionnaireID
        } else if segue.identifier == "textToEditTF" {
            let destination = segue.destination as! CreateTFViewController
            destination.questionText = questionTextTV.text
            destination.questionnaireType = questionnaireType
            destination.questionnaireID = self.questionnaireID
            destination.questionText = questionTextTV.text
        } else if segue.identifier == "textToEditMT" {
            let destination = segue.destination as! CreateMTViewController
            destination.questionText = questionTextTV.text
            destination.questionnaireType = questionnaireType
            destination.questionnaireID = self.questionnaireID
            destination.questionText = questionTextTV.text
        } else if segue.identifier == "textToEditRA" {
            let destination = segue.destination as! CreateRAViewController
            destination.questionText = questionTextTV.text
            destination.questionnaireType = questionnaireType
            destination.questionnaireID = self.questionnaireID
            destination.questionText = questionTextTV.text
        } else if segue.identifier == "textToEditSA" {
            let destination = segue.destination as! CreateSAViewController
            destination.questionText = questionTextTV.text
            destination.questionnaireType = questionnaireType
            destination.questionnaireID = self.questionnaireID
            destination.questionText = questionTextTV.text
        } else if segue.identifier == "textToEditES" {
            let destination = segue.destination as! CreateEssayViewController
            destination.questionText = questionTextTV.text
            destination.questionnaireType = questionnaireType
            destination.questionnaireID = self.questionnaireID
            destination.questionText = questionTextTV.text
        }
    }

}

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

}

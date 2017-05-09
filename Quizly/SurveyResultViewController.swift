//
//  SurveyResultViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 5/9/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class SurveyResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeBtn:UIBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(home))
        self.navigationItem.rightBarButtonItems = [homeBtn]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func home() {
        self.performSegue(withIdentifier: "surveyResultsToHome", sender: self)
    }

}

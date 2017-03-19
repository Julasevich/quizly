//
//  MainViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func takeActnButton(_ sender: Any) {
        self.performSegue(withIdentifier: "mainToAvailableQuizes", sender: self)
    }
    
    @IBAction func createActnBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "mainToCreatreHub", sender: self)
    }

}

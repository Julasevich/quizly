//
//  CreateQuestionnaireViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class CreateQuestionnaireViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //VARIABLES
    @IBOutlet weak var createQuestionnaireTable: UITableView!
    var questionnaires = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Delegate
        createQuestionnaireTable.delegate = self
        createQuestionnaireTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Questionnaires"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionnaires.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "createQuestionnaireCell", for: indexPath) as! CreateQuestionnaireTableViewCell
        if indexPath.row != questionnaires.count{
            //Question Cell
            cell.textLabel?.text = "Questionnaire \(indexPath.row)"
        } else {
            //Add Question Cell
            cell.textLabel?.text = "Add Questionnaire"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "createQuestionnaireToType", sender: self)
    }
    

}

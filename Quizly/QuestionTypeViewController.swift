//
//  QuestionTypeViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class QuestionTypeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionTypeTable: UITableView!
    var types = ["Multiple Choice", "True/False", "Matching", "Ranking", "Short Answer", "Essay"]
    var questionType = ""
    var questionnaireType = ""
    var questionnaireID = ""
    var questionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Delegate
        questionTypeTable.delegate = self
        questionTypeTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Question Type"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionTypeCell", for: indexPath) as! QuestionTypeTableViewCell
        cell.textLabel?.text = types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            questionType = "MC"
        } else if indexPath.row == 1 {
            questionType = "TF"
        } else if indexPath.row == 2 {
            questionType = "MT"
        } else if indexPath.row == 3 {
            questionType = "RA"
        } else if indexPath.row == 4 {
            questionType = "SA"
        } else if indexPath.row == 5 {
            questionType = "ES"
        }
        self.performSegue(withIdentifier: "typeToText", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "typeToText" {
            let destination = segue.destination as! QuestionnaireTextViewController
            destination.questionType = self.questionType
            destination.questionnaireType = self.questionnaireType
            destination.questionCount = self.questionCount
            destination.questionnaireID = self.questionnaireID
        }
    }

}

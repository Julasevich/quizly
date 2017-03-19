//
//  AddQuestionViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //VARIABLES
    @IBOutlet weak var addQuestionTable: UITableView!
    var questions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Delegate
        addQuestionTable.delegate = self
        addQuestionTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Edit Quiz"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addQuestionCell", for: indexPath) as! AddQuestionTableViewCell
        if indexPath.row != questions.count{
            //Question Cell
            cell.textLabel?.text = "Question \(indexPath.row)"
        } else {
            //Add Question Cell
            cell.textLabel?.text = "Add Question"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == questions.count {
            self.performSegue(withIdentifier: "addQuestionToSelectType", sender: self)
        }
        
    }

}

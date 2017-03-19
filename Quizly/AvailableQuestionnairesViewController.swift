//
//  AvailableQuestionnairesViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/19/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class AvailableQuestionnairesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var availableQuestionnairesTable: UITableView!
    
    var quizes = [String]()
    var surveys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Delegate
        availableQuestionnairesTable.delegate = self
        availableQuestionnairesTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Quizes"
        } else {
            return "Surveys"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if quizes.count == 0 {
                return 1
            } else {
                return quizes.count
            }
        } else {
            if surveys.count == 0 {
                return 1
            } else {
                return surveys.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availableQuestionnaires", for: indexPath) as! AvailableQuestionnairesTableViewCell
        if indexPath.section == 0 {
            //Quizes
            if quizes.count == 0 {
                //Empty
                cell.textLabel?.text = "None available."
            } else {
                cell.textLabel?.text = "Quiz \(indexPath.row)"
            }
        } else {
            if surveys.count == 0 {
                //Empty
                cell.textLabel?.text = "None available."
            } else {
                cell.textLabel?.text = "Quiz \(indexPath.row)"
            }
        }
        return cell
    }

}

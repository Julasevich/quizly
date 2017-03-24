//
//  CreateMultipleChoiceViewController.swift
//  Quizly
//
//  Created by Jacob Ulasevich on 3/24/17.
//  Copyright © 2017 Jacob Ulasevich. All rights reserved.
//

import UIKit

class CreateMultipleChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var createMCTable: UITableView!
    var options = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Delegate
        createMCTable.delegate = self
        createMCTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Edit Options"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "createMCCell", for: indexPath) as! CreateMultipleChoiceTableViewCell
        if indexPath.row != options.count{
            //Question Cell
            cell.textLabel?.text = "\(options[indexPath.row])"
        } else {
            //Add Question Cell
            cell.textLabel?.text = "Add Answer"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == options.count {
            createMCTable.beginUpdates()
            createMCTable.insertRows(at: [IndexPath(row: options.count, section:0)], with: .automatic)
            options.append("")
            createMCTable.endUpdates()
        }
        
    }

}
